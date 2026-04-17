<?php
// +----------------------------------------------------------------------
// | PayPal 支付（海外主流支付）
// +----------------------------------------------------------------------

namespace extend\payment;

use think\facade\Log;

class PayPal extends PaymentGateway
{
    protected $channelCode = 'paypal';
    protected $channelName = 'PayPal';
    
    /**
     * API 基础 URL
     */
    const SANDBOX_URL = 'https://api.sandbox.paypal.com';
    const LIVE_URL = 'https://api.paypal.com';
    
    /**
     * 获取 API URL
     */
    private function getApiUrl(): string
    {
        return $this->config['mode'] === 'live' ? self::LIVE_URL : self::SANDBOX_URL;
    }
    
    /**
     * 获取 Access Token
     */
    private function getAccessToken(): string
    {
        $cacheKey = 'paypal_access_token';
        $token = cache($cacheKey);
        
        if ($token) {
            return $token;
        }
        
        $url = $this->getApiUrl() . '/v1/oauth2/token';
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, 'grant_type=client_credentials');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERPWD, $this->config['client_id'] . ':' . $this->config['secret']);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/x-www-form-urlencoded',
            'Accept: application/json'
        ]);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        if ($httpCode !== 200) {
            throw new \Exception('获取 PayPal Token 失败');
        }
        
        $data = json_decode($response, true);
        $token = $data['access_token'];
        
        // 缓存 token（有效期通常 32400 秒）
        cache($cacheKey, $token, 32000);
        
        return $token;
    }
    
    /**
     * 创建支付订单
     * @param array $order 订单信息
     * @return array 支付参数
     */
    public function createOrder(array $order): array
    {
        $this->log('创建 PayPal 订单', $order);
        
        $accessToken = $this->getAccessToken();
        $url = $this->getApiUrl() . '/v2/checkout/orders';
        
        $params = [
            'intent' => 'CAPTURE',
            'purchase_units' => [[
                'reference_id' => $order['order_no'],
                'amount' => [
                    'currency_code' => $order['currency'] ?? 'USD',
                    'value' => number_format($order['amount'], 2, '.', '')
                ],
                'description' => $order['subject'] ?? '短剧购买',
                'custom_id' => $order['order_no'], // 自定义 ID（订单号）
                'invoice_id' => $order['order_no'] // 发票 ID
            ]],
            'application_context' => [
                'brand_name' => 'DramaHub',
                'locale' => $order['locale'] ?? 'en-US',
                'landing_page' => 'NO_PREFERENCE',
                'user_action' => 'PAY_NOW',
                'return_url' => $this->config['return_url'] . '?order_no=' . $order['order_no'],
                'cancel_url' => $this->config['cancel_url'] . '?order_no=' . $order['order_no']
            ]
        ];
        
        $headers = [
            'Content-Type: application/json',
            'Authorization: Bearer ' . $accessToken,
            'Prefer: return=representation'
        ];
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($params));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        if ($httpCode !== 201) {
            $this->log('创建 PayPal 订单失败', ['http_code' => $httpCode, 'response' => $response]);
            throw new \Exception('PayPal 下单失败：' . $response);
        }
        
        $result = json_decode($response, true);
        
        // 获取支付链接
        $approveUrl = '';
        foreach ($result['links'] as $link) {
            if ($link['rel'] === 'approve') {
                $approveUrl = $link['href'];
                break;
            }
        }
        
        $this->log('创建 PayPal 订单成功', [
            'order_no' => $order['order_no'],
            'paypal_order_id' => $result['id'],
            'approve_url' => $approveUrl
        ]);
        
        return [
            'success' => true,
            'order_no' => $order['order_no'],
            'paypal_order_id' => $result['id'],
            'approve_url' => $approveUrl, // H5 跳转链接
            'pay_params' => [
                'order_id' => $result['id'],
                'approve_url' => $approveUrl
            ]
        ];
    }
    
    /**
     * 处理支付回调
     * @param mixed $request 回调数据
     * @return array 处理结果
     */
    public function handleCallback($request): array
    {
        $this->log('收到 PayPal 回调', (array)$request);
        
        $orderId = $request['order_id'] ?? '';
        $token = $request['token'] ?? '';
        $PayerID = $request['PayerID'] ?? '';
        
        if (!$orderId || !$PayerID) {
            return ['success' => false, 'message' => '参数不完整'];
        }
        
        try {
            // 捕获支付
            $captureResult = $this->captureOrder($orderId);
            
            if ($captureResult['status'] === 'COMPLETED') {
                $purchaseUnit = $captureResult['purchase_units'][0];
                $payment = $purchaseUnit['payments']['captures'][0];
                
                $this->log('PayPal 支付成功', [
                    'order_no' => $purchaseUnit['custom_id'],
                    'paypal_order_id' => $orderId,
                    'amount' => $payment['amount']['value'],
                    'currency' => $payment['amount']['currency_code']
                ]);
                
                return [
                    'success' => true,
                    'order_no' => $purchaseUnit['custom_id'],
                    'transaction_id' => $payment['id'],
                    'amount' => (float)$payment['amount']['value'],
                    'currency' => $payment['amount']['currency_code'],
                    'pay_time' => strtotime($payment['create_time'])
                ];
            }
            
            return ['success' => false, 'message' => '支付状态：' . $captureResult['status']];
            
        } catch (\Exception $e) {
            $this->log('PayPal 回调处理失败', ['error' => $e->getMessage()]);
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    /**
     * 捕获订单（完成支付）
     */
    private function captureOrder(string $orderId): array
    {
        $accessToken = $this->getAccessToken();
        $url = $this->getApiUrl() . '/v2/checkout/orders/' . $orderId . '/capture';
        
        $headers = [
            'Content-Type: application/json',
            'Authorization: Bearer ' . $accessToken
        ];
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, '');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        if ($httpCode !== 201) {
            throw new \Exception('PayPal 捕获支付失败：' . $response);
        }
        
        return json_decode($response, true);
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
        $this->log('发起 PayPal 退款', [
            'transaction_id' => $transactionId,
            'amount' => $amount,
            'reason' => $reason
        ]);
        
        $accessToken = $this->getAccessToken();
        $url = $this->getApiUrl() . '/v2/payments/captures/' . $transactionId . '/refund';
        
        $params = [
            'amount' => [
                'currency_code' => 'USD',
                'value' => number_format($amount, 2, '.', '')
            ],
            'note_to_payer' => $reason ?: 'Refund'
        ];
        
        $headers = [
            'Content-Type: application/json',
            'Authorization: Bearer ' . $accessToken
        ];
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($params));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        if (!in_array($httpCode, [200, 201])) {
            $this->log('PayPal 退款失败', ['http_code' => $httpCode, 'response' => $response]);
            return ['success' => false, 'message' => '退款失败'];
        }
        
        $result = json_decode($response, true);
        
        $this->log('PayPal 退款成功', $result);
        
        return [
            'success' => true,
            'refund_id' => $result['id'],
            'status' => $result['status'],
            'create_time' => $result['create_time']
        ];
    }
    
    /**
     * 查询订单状态
     * @param string $transactionId 交易号
     * @return array 订单状态
     */
    public function queryOrder(string $transactionId): array
    {
        $accessToken = $this->getAccessToken();
        $url = $this->getApiUrl() . '/v2/checkout/orders/' . $transactionId;
        
        $headers = [
            'Authorization: Bearer ' . $accessToken
        ];
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        if ($httpCode !== 200) {
            return ['status' => 'NOT_FOUND'];
        }
        
        $result = json_decode($response, true);
        
        return [
            'transaction_id' => $transactionId,
            'status' => $result['status'],
            'amount' => $result['purchase_units'][0]['amount']['value'],
            'currency' => $result['purchase_units'][0]['amount']['currency_code']
        ];
    }
    
    /**
     * 获取渠道类型
     * @return string
     */
    public function getChannelType(): string
    {
        return 'overseas';
    }
    
    /**
     * 生成签名（PayPal 不需要）
     */
    protected function generateSign(array $params): string
    {
        return '';
    }
    
    /**
     * 验证签名（PayPal 不需要）
     */
    protected function verifySign(array $params, string $sign): bool
    {
        return true;
    }
}
