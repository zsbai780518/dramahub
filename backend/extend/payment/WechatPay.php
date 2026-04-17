<?php
// +----------------------------------------------------------------------
// | 微信支付（跨境支付）
// +----------------------------------------------------------------------

namespace extend\payment;

use think\facade\Log;

class WechatPay extends PaymentGateway
{
    protected $channelCode = 'wechat';
    protected $channelName = '微信支付';
    
    /**
     * 基础 URL
     */
    const BASE_URL = 'https://api.mch.weixin.qq.com';
    
    /**
     * 创建支付订单
     * @param array $order 订单信息
     * @return array 支付参数
     */
    public function createOrder(array $order): array
    {
        $this->log('创建订单', $order);
        
        $params = [
            'appid' => $this->config['app_id'],
            'mchid' => $this->config['mch_id'],
            'out_trade_no' => $order['order_no'],
            'transaction_type' => $order['trade_type'] ?? 'APP', // APP|JSAPI|NATIVE
            'amount' => [
                'total' => (int)($order['amount'] * 100), // 单位：分
                'currency' => $order['currency'] ?? 'CNY'
            ],
            'description' => $order['subject'] ?? '短剧购买',
            'notify_url' => $this->config['notify_url'],
            'time_expire' => date('c', time() + 1800) // 30 分钟后过期
        ];
        
        // 添加付款人信息（跨境支付需要）
        if (!empty($order['payer'])) {
            $params['payer'] = $order['payer'];
        }
        
        // 生成签名
        $params['sign'] = $this->generateSign($params);
        
        // 调用微信 API
        $response = $this->httpPost(self::BASE_URL . '/v3/transactions/transaction_type', $params);
        
        if ($response['http_code'] !== 200) {
            $this->log('创建订单失败', $response);
            throw new \Exception('微信支付下单失败：' . json_encode($response['body']));
        }
        
        $result = $response['body'];
        
        // 返回前端调起支付的参数
        $payParams = [
            'appid' => $this->config['app_id'],
            'partnerid' => $this->config['mch_id'],
            'prepayid' => $result['prepay_id'],
            'package' => 'Sign=WXPay',
            'noncestr' => $this->generateNonceStr(),
            'timestamp' => time(),
            'sign' => $this->generatePaySign([
                $this->config['app_id'],
                time(),
                $this->generateNonceStr(),
                'prepay_id=' . $result['prepay_id'],
            ])
        ];
        
        $this->log('创建订单成功', ['order_no' => $order['order_no'], 'prepay_id' => $result['prepay_id']]);
        
        return [
            'success' => true,
            'order_no' => $order['order_no'],
            'pay_params' => $payParams,
            'transaction_id' => $result['transaction_id'] ?? ''
        ];
    }
    
    /**
     * 处理支付回调
     * @param mixed $request 回调数据
     * @return array 处理结果
     */
    public function handleCallback($request): array
    {
        $this->log('收到回调', (array)$request);
        
        // 验证签名
        $signature = $request['signature'] ?? '';
        $body = $request['body'] ?? '';
        $serial = $request['serial'] ?? '';
        
        if (!$this->verifySign(['body' => $body, 'serial' => $serial], $signature)) {
            $this->log('回调签名验证失败', $request);
            return ['success' => false, 'message' => '签名验证失败'];
        }
        
        // 解密回调数据
        $decryptData = $this->decryptCallback($body);
        
        $orderNo = $decryptData['out_trade_no'];
        $transactionId = $decryptData['transaction_id'];
        $amount = $decryptData['amount']['total'] / 100;
        $tradeState = $decryptData['trade_state'];
        
        // 判断支付状态
        if ($tradeState === 'SUCCESS') {
            $this->log('支付成功', [
                'order_no' => $orderNo,
                'transaction_id' => $transactionId,
                'amount' => $amount
            ]);
            
            return [
                'success' => true,
                'order_no' => $orderNo,
                'transaction_id' => $transactionId,
                'amount' => $amount,
                'pay_time' => strtotime($decryptData['success_time'])
            ];
        }
        
        return ['success' => false, 'message' => '支付状态：' . $tradeState];
    }
    
    /**
     * 退款处理
     * @param string $transactionId 交易号
     * @param float $amount 退款金额
     * @param string $reason 退款原因
     * @return array 退款结果
     */
    public function refund(string $transactionId, float $amount, string $reason = ''): array
    {
        $this->log('发起退款', [
            'transaction_id' => $transactionId,
            'amount' => $amount,
            'reason' => $reason
        ]);
        
        $params = [
            'transaction_id' => $transactionId,
            'out_refund_no' => 'R' . time() . rand(1000, 9999),
            'amount' => [
                'refund' => (int)($amount * 100),
                'total' => (int)($amount * 100),
                'currency' => 'CNY'
            ],
            'reason' => $reason ?: '用户申请退款',
            'notify_url' => $this->config['refund_notify_url'] ?? $this->config['notify_url']
        ];
        
        $params['sign'] = $this->generateSign($params);
        
        $response = $this->httpPost(self::BASE_URL . '/v3/refund/domestic/refunds', $params);
        
        if ($response['http_code'] !== 200) {
            $this->log('退款失败', $response);
            return ['success' => false, 'message' => '退款失败'];
        }
        
        $this->log('退款成功', $response['body']);
        
        return [
            'success' => true,
            'refund_id' => $response['body']['refund_id'],
            'refund_no' => $response['body']['out_refund_no'],
            'status' => $response['body']['status']
        ];
    }
    
    /**
     * 查询订单状态
     * @param string $transactionId 交易号
     * @return array 订单状态
     */
    public function queryOrder(string $transactionId): array
    {
        $url = self::BASE_URL . '/v3/transactions/id/' . $transactionId;
        
        $response = $this->httpGet($url);
        
        if ($response['http_code'] !== 200) {
            return ['status' => 'NOT_FOUND'];
        }
        
        return [
            'transaction_id' => $transactionId,
            'out_trade_no' => $response['body']['out_trade_no'],
            'trade_state' => $response['body']['trade_state'],
            'amount' => $response['body']['amount']['total'] / 100,
            'success_time' => $response['body']['success_time'] ?? ''
        ];
    }
    
    /**
     * 获取渠道类型
     * @return string
     */
    public function getChannelType(): string
    {
        return 'wechat';
    }
    
    /**
     * 生成签名（使用 API v3 密钥）
     */
    protected function generateSign(array $params): string
    {
        // 微信 v3 签名逻辑
        $privateKey = $this->config['private_key'];
        $message = $this->buildSignMessage($params);
        
        $signature = '';
        openssl_sign($message, $signature, $privateKey, 'sha256WithRSAEncryption');
        
        return base64_encode($signature);
    }
    
    /**
     * 验证签名
     */
    protected function verifySign(array $params, string $sign): bool
    {
        $publicKey = $this->config['wechat_public_cert'];
        $message = $params['body'];
        
        $result = openssl_verify(
            $message,
            base64_decode($sign),
            $publicKey,
            'sha256WithRSAEncryption'
        );
        
        return $result === 1;
    }
    
    /**
     * 生成随机字符串
     */
    private function generateNonceStr(int $length = 32): string
    {
        $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        $str = '';
        for ($i = 0; $i < $length; $i++) {
            $str .= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
        }
        return $str;
    }
    
    /**
     * 生成支付签名
     */
    private function generatePaySign(array $params): string
    {
        $signStr = implode("\n", $params) . "\n";
        $signature = '';
        openssl_sign($signStr, $signature, $this->config['private_key'], 'sha256WithRSAEncryption');
        return base64_encode($signature);
    }
    
    /**
     * 构建签名消息
     */
    private function buildSignMessage(array $params): string
    {
        $method = 'POST';
        $url = '/v3/transactions/transaction_type';
        $timestamp = time();
        $nonceStr = $this->generateNonceStr();
        $body = json_encode($params, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        
        return "{$method}\n{$url}\n{$timestamp}\n{$nonceStr}\n{$body}\n";
    }
    
    /**
     * 解密回调数据
     */
    private function decryptCallback(string $body): array
    {
        $data = json_decode($body, true);
        $resource = $data['resource'];
        
        $ciphertext = base64_decode($resource['ciphertext']);
        $nonce = $resource['nonce'];
        $associatedData = $resource['associated_data'];
        $key = $this->config['api_v3_key'];
        
        $decrypted = openssl_decrypt(
            $ciphertext,
            'aes-256-gcm',
            $key,
            OPENSSL_RAW_DATA,
            $nonce,
            $associatedData,
            substr($resource['ciphertext'], -16)
        );
        
        return json_decode($decrypted, true);
    }
    
    /**
     * HTTP GET 请求
     */
    private function httpGet(string $url): array
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        return [
            'http_code' => $httpCode,
            'body' => json_decode($response, true) ?: $response
        ];
    }
}
