# ThinkPHP6 后端项目结构说明

## 目录结构

```
backend/
├── app/                          # 应用目录
│   ├── controller/               # 控制器
│   │   ├── api/                  # API 接口控制器
│   │   │   ├── User.php          # 用户接口
│   │   │   ├── Drama.php         # 短剧接口
│   │   │   ├── Episode.php       # 剧集接口
│   │   │   ├── Order.php         # 订单接口
│   │   │   ├── Payment.php       # 支付接口
│   │   │   ├── Member.php        # 会员接口
│   │   │   └── Category.php      # 分类接口
│   │   ├── provider/             # 内容方后台控制器
│   │   │   ├── Dashboard.php     # 仪表盘
│   │   │   ├── Content.php       # 内容管理
│   │   │   ├── Data.php          # 数据统计
│   │   │   ├── Finance.php       # 财务管理
│   │   │   └── Account.php       # 账号管理
│   │   └── admin/                # 平台运营总后台控制器
│   │       ├── User.php          # 用户管理
│   │       ├── Content.php       # 内容管理
│   │       ├── Order.php         # 订单管理
│   │       ├── Payment.php       # 支付管理
│   │       ├── Operation.php     # 运营管理
│   │       └── System.php        # 系统管理
│   ├── model/                    # 模型
│   │   ├── User.php
│   │   ├── Drama.php
│   │   ├── Episode.php
│   │   ├── Order.php
│   │   ├── PaymentRecord.php
│   │   ├── Member.php
│   │   ├── Category.php
│   │   ├── ContentProvider.php
│   │   ├── ProfitRecord.php
│   │   ├── Withdraw.php
│   │   ├── Coupon.php
│   │   └── SystemConfig.php
│   ├── service/                  # 业务逻辑层
│   │   ├── UserService.php       # 用户服务
│   │   ├── DramaService.php      # 短剧服务
│   │   ├── OrderService.php      # 订单服务
│   │   ├── PaymentService.php    # 支付服务
│   │   ├── MemberService.php     # 会员服务
│   │   ├── ProfitService.php     # 分润服务
│   │   ├── ContentAuditService.php # 内容审核服务
│   │   └── SmsService.php        # 短信服务
│   ├── validate/                 # 验证器
│   │   ├── User.php
│   │   ├── Order.php
│   │   ├── Payment.php
│   │   └── Drama.php
│   ├── common/                   # 公共模块
│   │   ├── Controller.php        # 基础控制器
│   │   ├── Model.php             # 基础模型
│   │   ├── Exception.php         # 异常处理
│   │   └── helpers.php           # 辅助函数
│   └── command/                  # 命令行工具
│       ├── SyncExchangeRate.php  # 同步汇率
│       ├── CloseExpiredOrder.php # 关闭过期订单
│       ├── CalculateProfit.php   # 计算分润
│       └── SendPushNotification.php # 发送推送
├── config/                       # 配置目录
│   ├── app.php                   # 应用配置
│   ├── database.php              # 数据库配置
│   ├── cache.php                 # 缓存配置
│   ├── middleware.php            # 中间件配置
│   ├── route.php                 # 路由配置
│   └── payment.php               # 支付配置
├── extend/                       # 扩展类库
│   └── payment/                  # 支付网关
│       ├── PaymentGateway.php    # 支付网关基类
│       ├── PayPal.php            # PayPal 支付
│       ├── Stripe.php            # Stripe 支付
│       ├── WechatPay.php         # 微信支付
│       ├── Alipay.php            # 支付宝支付
│       └── ...                   # 其他支付渠道
├── public/                       # 公共目录
│   ├── index.php                 # 入口文件
│   ├── .htaccess                 # Apache 重写规则
│   └── static/                   # 静态资源
├── runtime/                      # 运行时目录
└── route/                        # 路由定义
    ├── api.php                   # API 路由
    ├── provider.php              # 内容方后台路由
    └── admin.php                 # 运营后台路由
```

## 核心模块说明

### 1. 支付网关模块 (extend/payment/)

```php
// 支付网关基类
namespace extend\payment;

abstract class PaymentGateway {
    protected $config;
    
    // 创建订单
    abstract public function createOrder($orderNo, $amount, $currency, $subject);
    
    // 处理回调
    abstract public function handleCallback($request);
    
    // 退款
    abstract public function refund($transactionId, $amount, $reason);
    
    // 查询订单
    abstract public function queryOrder($transactionId);
}
```

### 2. 中间件

- `Auth.php` - 用户身份验证
- `AdminAuth.php` - 后台管理员验证
- `ProviderAuth.php` - 内容方验证
- `PaymentSign.php` - 支付签名验证
- `CrossDomain.php` - 跨域处理
- `RequestLog.php` - 请求日志

### 3. 核心 API 接口

#### 用户接口 (api/User)
- POST /api/user/register - 用户注册
- POST /api/user/login - 用户登录
- POST /api/user/logout - 用户登出
- GET /api/user/info - 获取用户信息
- PUT /api/user/profile - 更新用户资料

#### 短剧接口 (api/Drama)
- GET /api/drama/list - 短剧列表
- GET /api/drama/detail - 短剧详情
- GET /api/drama/recommend - 推荐短剧
- GET /api/drama/search - 搜索短剧

#### 剧集接口 (api/Episode)
- GET /api/episode/list - 剧集列表
- GET /api/episode/play - 获取播放地址
- GET /api/episode/unlock - 检查解锁状态

#### 订单接口 (api/Order)
- POST /api/order/create - 创建订单
- GET /api/order/list - 订单列表
- GET /api/order/detail - 订单详情
- POST /api/order/refund - 申请退款

#### 支付接口 (api/Payment)
- POST /api/payment/pay - 发起支付
- POST /api/payment/callback/:channel - 支付回调
- POST /api/payment/refund - 退款处理

## 数据库配置 (config/database.php)

```php
return [
    'default' => 'mysql',
    'connections' => [
        'mysql' => [
            'type' => 'mysql',
            'hostname' => '127.0.0.1',
            'database' => 'drama_platform',
            'username' => 'root',
            'password' => '',
            'hostport' => '3306',
            'charset' => 'utf8mb4',
            'prefix' => '',
        ],
    ],
];
```

## 支付配置 (config/payment.php)

```php
return [
    'wechat' => [
        'app_id' => '',
        'mch_id' => '',
        'key' => '',
        'cert_path' => '',
        'key_path' => '',
        'notify_url' => '/api/payment/callback/wechat',
    ],
    'alipay' => [
        'app_id' => '',
        'private_key' => '',
        'alipay_public_key' => '',
        'notify_url' => '/api/payment/callback/alipay',
    ],
    'paypal' => [
        'client_id' => '',
        'secret' => '',
        'mode' => 'sandbox', // sandbox | live
        'notify_url' => '/api/payment/callback/paypal',
    ],
    'stripe' => [
        'secret_key' => '',
        'publishable_key' => '',
        'webhook_secret' => '',
    ],
];
```

## 环境要求

- PHP >= 8.1
- MySQL >= 8.0
- Apache >= 2.4
- Redis >= 6.0
- ThinkPHP >= 6.0

## 安装步骤

1. 配置 LAMP 环境
2. 创建数据库并导入 SQL 文件
3. 修改 config/database.php 配置
4. 修改 config/payment.php 配置
5. 设置 public 目录为网站根目录
6. 开启 Apache 重写模块
7. 设置 runtime 目录权限 777
