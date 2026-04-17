<?php
// +----------------------------------------------------------------------
// | 支付网关基类
// +----------------------------------------------------------------------

namespace extend\payment;

use think\facade\Log;
use think\exception\HttpException;

abstract class PaymentGateway
{
    /**
     * 支付渠道配置
     */
    protected $config;
    
    /**
     * 支付渠道代码
     */
    protected $channelCode;
    
    /**
     * 支付渠道名称
     */
    protected $channelName;
    
    /**
     * 构造函数
     */
    public function __construct($config = [])
    {
        $this->config = $config;
    }
    
    /**
     * 创建支付订单
     * @param array $order 订单信息
     * @return array 支付参数
     */
    abstract public function createOrder(array $order): array;
    
    /**
     * 处理支付回调
     * @param mixed $request 回调数据
     * @return array 处理结果 ['success' => true/false, 'order_no' => '订单号', 'amount' => 金额]
     */
    abstract public function handleCallback($request): array;
    
    /**
     * 退款处理
     * @param string $transactionId 交易号
     * @param float $amount 退款金额
     * @param string $reason 退款原因
     * @return array 退款结果
     */
    abstract public function refund(string $transactionId, float $amount, string $reason = ''): array;
    
    /**
     * 查询订单状态
     * @param string $transactionId 交易号
     * @return array 订单状态
     */
    abstract public function queryOrder(string $transactionId): array;
    
    /**
     * 获取支付渠道信息
     * @return array
     */
    public function getChannelInfo(): array
    {
        return [
            'code' => $this->channelCode,
            'name' => $this->channelName,
            'type' => $this->getChannelType()
        ];
    }
    
    /**
     * 获取渠道类型
     * @return string overseas|wechat|alipay
     */
    abstract public function getChannelType(): string;
    
    /**
     * 记录支付日志
     * @param string $action 操作类型
     * @param array $data 数据
     * @return void
     */
    protected function log(string $action, array $data): void
    {
        Log::channel('payment')->info("【{$this->channelName}】{$action}", $data);
    }
    
    /**
     * 生成签名
     * @param array $params 参数
     * @return string 签名
     */
    abstract protected function generateSign(array $params): string;
    
    /**
     * 验证签名
     * @param array $params 参数
     * @param string $sign 签名
     * @return bool
     */
    abstract protected function verifySign(array $params, string $sign): bool;
    
    /**
     * HTTP POST 请求
     * @param string $url 请求地址
     * @param array $data 请求数据
     * @param int $timeout 超时时间
     * @return array 响应结果
     */
    protected function httpPost(string $url, array $data, int $timeout = 30): array
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Accept: application/json'
        ]);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);
        curl_close($ch);
        
        if ($error) {
            throw new HttpException(500, "HTTP 请求失败：{$error}");
        }
        
        return [
            'http_code' => $httpCode,
            'body' => json_decode($response, true) ?: $response
        ];
    }
}
