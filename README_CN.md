# DramaHub - 海外短视频短剧发行平台

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![PHP](https://img.shields.io/badge/PHP-8.1+-blue.svg)](https://www.php.net/)
[![ThinkPHP](https://img.shields.io/badge/ThinkPHP-6.0-blue.svg)](https://www.thinkphp.cn/)
[![UniApp](https://img.shields.io/badge/UniApp-1.x-green.svg)](https://uniapp.dcloud.net.cn/)

> 🎬 全球化一站式短视频短剧付费发行平台 - 支持海外主流支付 + 微信/支付宝跨境支付

---

## 📖 目录

- [项目简介](#-项目简介)
- [核心功能](#-核心功能)
- [技术架构](#-技术架构)
- [支付体系](#-支付体系)
- [项目结构](#-项目结构)
- [快速开始](#-快速开始)
- [API 文档](#-api-文档)
- [开发路线图](#-开发路线图)
- [贡献指南](#-贡献指南)
- [开源协议](#-开源协议)

---

## 🌟 项目简介

DramaHub 是一个面向全球市场的短视频短剧发行平台，为海外短剧内容市场提供完整的 B2B2C 解决方案。

**核心优势：**
- 🌍 **全球化支付** - 支持 PayPal、Stripe 等海外主流支付 + 微信/支付宝跨境支付
- 📱 **多端覆盖** - UniApp 一套代码编译生成 APP（iOS/Android）+ H5
- 🎯 **完整生态** - 内容上传、审核、分发、付费、分润全流程
- 🛡️ **合规安全** - 遵循 GDPR、CCPA 等国际法规

**目标用户：**
- **B 端内容方：** 短剧出品公司、MCN 机构、内容创作者
- **C 端用户：** 海外本地用户、海外华人、出境中国人（旅游/工作/留学）

---

## ✨ 核心功能

### C 端用户端（UniApp）

| 功能模块 | 功能说明 |
|----------|----------|
| 👤 用户注册登录 | 邮箱、手机号、Google、Facebook、微信、支付宝登录 |
| 🎬 短剧内容浏览 | 分类、推荐、搜索、热搜榜 |
| 📺 视频播放 | 试看（3-5 分钟）、多画质、多语言字幕 |
| 💳 付费中心 | 单集解锁、全集打包、会员订阅、充值礼包 |
| 👤 个人中心 | 会员、订单、钱包、观看历史 |

### B 端内容方后台

| 功能模块 | 功能说明 |
|----------|----------|
| 📝 内容方入驻 | 入驻申请、资质审核、账号管理 |
| 📤 内容上传管理 | 视频上传、编辑、发行配置、上下架 |
| 📊 数据统计 | 播放量、用户画像、收益数据、分润明细 |
| 💰 分润与提现 | 分润规则、提现申请、提现记录 |

### 平台运营总后台

| 功能模块 | 功能说明 |
|----------|----------|
| 👥 用户管理 | C 端用户、B 端内容方、权限管理 |
| 🎬 内容管理 | 内容审核、分类管理、版权管控 |
| 💳 订单与支付 | 订单管理、支付渠道、对账管理 |
| 📈 运营营销 | 活动管理、推送管理、广告位 |
| ⚙️ 系统管理 | 权限、配置、日志 |

---

## 🏗️ 技术架构

### 后端架构

```
┌─────────────────────────────────────────┐
│           应用层 (ThinkPHP 6.0 MVC)      │
├─────────────────────────────────────────┤
│           业务逻辑层                     │
│   用户 | 内容 | 订单 | 支付 | 会员 | 分润  │
├─────────────────────────────────────────┤
│           数据持久层                     │
│   MySQL 8.0 (主从) + Redis 6.0          │
├─────────────────────────────────────────┤
│           基础设施层                     │
│   LAMP (Linux + Apache + MySQL + PHP)   │
└─────────────────────────────────────────┘
```

**核心技术栈：**
- **服务器：** Linux（CentOS 7.6+ / Ubuntu 20.04+）
- **Web 服务器：** Apache 2.4+（开启 mod_rewrite）
- **数据库：** MySQL 8.0（主从复制）
- **缓存：** Redis 6.0+
- **开发语言：** PHP 8.1+
- **框架：** ThinkPHP 6.0 LTS

### 前端架构

```
┌─────────────────────────────────────────┐
│           UniApp 跨端框架                │
│      (一套代码，多端运行)                 │
├──────────┬──────────────┬───────────────┤
│  iOS APP │ Android APP  │    H5 网页     │
└──────────┴──────────────┴───────────────┘
```

**核心技术栈：**
- **框架：** UniApp（基于 Vue.js）
- **多端：** iOS、Android、H5
- **状态管理：** Vuex
- **国际化：** i18n（6 种语言）
- **视频播放：** 原生 + HLS 支持

### 第三方服务

| 服务 | 提供商 | 用途 |
|------|--------|------|
| 对象存储 | 阿里云 OSS / 腾讯云 COS | 视频存储 |
| CDN | 全球 CDN | 视频加速 |
| 短信 | Twilio / 阿里云短信 | 验证码 |
| 推送 | Firebase / 极光推送 | APP 推送 |
| 内容审核 | 第三方 AI | 内容审核 |

---

## 💳 支付体系

### 海外主流支付渠道

| 渠道 | 覆盖地区 | 币种 | 状态 |
|------|----------|------|------|
| **PayPal** | 200+ 国家 | USD, EUR, GBP 等 | ✅ 就绪 |
| **Stripe** | 全球 | 信用卡 | ⏳ 待开发 |
| **Google Pay** | 全球 | 本地币种 | ⏳ 待开发 |
| **Apple Pay** | 全球 | 本地币种 | ⏳ 待开发 |

### 区域本地化支付

| 地区 | 支付方式 |
|------|----------|
| 🇺🇸🇪🇺 欧美 | PayPal、Stripe、信用卡 |
| 🇸🇬🇹🇭🇮🇩 东南亚 | GoPay、Dana、Touch'n Go、GCash |
| 🇸🇦🇦🇪 中东 | Fawry、Mada、PayFort |
| 🇧🇷🇲🇽 拉美 | Pix、Mercado Pago |

### 跨境支付（核心特色）

| 渠道 | 说明 | 状态 |
|------|------|------|
| **微信支付国际版** | 覆盖 200+ 国家，支持境外信用卡/国内余额 | ✅ 就绪 |
| **支付宝国际收单** | 全球支付宝用户，实时汇率换算 | ✅ 就绪 |

### 支付网关架构

```
┌─────────────────────────────────────────────────────────┐
│                    支付网关                             │
├─────────────┬─────────────┬─────────────┬───────────────┤
│   PayPal    │   Stripe    │  微信支付   │    支付宝     │
├─────────────┴─────────────┴─────────────┴───────────────┤
│                  统一支付接口                            │
├─────────────────────────────────────────────────────────┤
│  订单管理 | 汇率换算 | 风控校验 | 退款处理               │
└─────────────────────────────────────────────────────────┘
```

**核心功能：**
- 🔄 多币种支持，实时汇率换算
- 🛡️ 欺诈交易检测，风控系统
- 📊 自动对账，自动结算
- 💸 原路退款，退款状态同步
- 🔐 PCI DSS 合规

---

## 📁 项目结构

```
dramahub/
├── backend/                    # ThinkPHP 6 后端
│   ├── app/
│   │   ├── controller/        # API 控制器
│   │   │   ├── api/          # C 端接口
│   │   │   ├── provider/     # B 端控制器
│   │   │   └── admin/        # 后台控制器
│   │   ├── model/            # 数据库模型
│   │   ├── service/          # 业务逻辑
│   │   └── validate/         # 验证器
│   ├── extend/payment/       # 支付网关
│   │   ├── PaymentGateway.php
│   │   ├── WechatPay.php
│   │   └── PayPal.php
│   ├── config/               # 配置文件
│   ├── public/               # 公共资源
│   └── runtime/              # 运行时目录
├── frontend/                  # UniApp 前端
│   ├── pages/                # 页面
│   ├── components/           # 组件
│   ├── api/                  # API 客户端
│   ├── utils/                # 工具类
│   ├── store/                # Vuex 状态管理
│   ├── locale/               # 多语言包
│   └── static/               # 静态资源
├── docs/                      # 文档目录
├── .github/                   # GitHub 配置
│   └── workflows/            # CI/CD 流水线
├── database.sql               # 数据库脚本
├── README.md                  # 本文件
└── LICENSE                    # MIT 协议
```

---

## 🚀 快速开始

### 环境要求

- PHP >= 8.1
- MySQL >= 8.0
- Apache >= 2.4（开启 mod_rewrite）
- Redis >= 6.0
- Node.js >= 14（前端编译）
- Composer >= 2.0
- Git

### 后端部署

```bash
# 1. 克隆项目
git clone https://github.com/zsbai780518/dramahub.git
cd dramahub/backend

# 2. 安装依赖（如使用 Composer）
composer install

# 3. 配置数据库
# 编辑 config/database.php 填入数据库信息
# 或复制示例：
cp config/database.example.php config/database.php

# 4. 导入数据库
mysql -u root -p dramahub < database.sql

# 5. 设置权限
chmod -R 777 runtime/
chmod -R 777 public/uploads/

# 6. 配置虚拟主机（Apache）
# 将 public 目录设置为网站根目录
# 启用 .htaccess 重写规则

# 7. 配置支付渠道
# 编辑 config/payment.php 填入各支付渠道参数
```

### Apache 虚拟主机配置

```apache
<VirtualHost *:80>
    ServerName dramahub.local
    DocumentRoot "/path/to/dramahub/backend/public"
    
    <Directory "/path/to/dramahub/backend/public">
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/dramahub_error.log
    CustomLog ${APACHE_LOG_DIR}/dramahub_access.log combined
</VirtualHost>
```

### 前端部署

```bash
# 1. 进入前端目录
cd dramahub/frontend

# 2. 安装依赖
npm install

# 3. 配置 API 地址
# 编辑 utils/request.js 填入后端 URL
# const BASE_URL = 'https://api.yourdomain.com'

# 4. 运行开发服务器
# H5
npm run dev:h5

# APP
npm run dev:app

# 5. 生产环境打包
npm run build:h5
npm run build:app-android
npm run build:app-ios
```

### 环境配置

在 backend 根目录创建 `.env` 文件：

```env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://api.yourdomain.com

DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=dramahub
DB_USERNAME=root
DB_PASSWORD=your_password

REDIS_HOST=127.0.0.1
REDIS_PORT=6379
REDIS_PASSWORD=

# 支付配置
WECHAT_PAY_APP_ID=your_app_id
WECHAT_PAY_MCH_ID=your_mch_id
WECHAT_PAY_KEY=your_key

PAYPAL_CLIENT_ID=your_client_id
PAYPAL_SECRET=your_secret
PAYPAL_MODE=live
```

---

## 📡 API 文档

### 用户注册接口

```http
POST /api/user/register
Content-Type: application/json

请求：
{
  "email": "user@example.com",
  "password": "password123",
  "phone": "+8613800138000"
}

响应：
{
  "code": 0,
  "msg": "success",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": 1,
      "email": "user@example.com",
      "nickname": "用户昵称"
    }
  }
}
```

### 短剧列表接口

```http
GET /api/drama/list?page=1&limit=20&category=1
Authorization: Bearer {token}

响应：
{
  "code": 0,
  "data": {
    "total": 100,
    "list": [
      {
        "id": 1,
        "title": "甜蜜爱情故事",
        "cover_image": "https://cdn.example.com/cover.jpg",
        "total_episodes": 80,
        "view_count": 150000
      }
    ]
  }
}
```

### 支付接口

```http
POST /api/payment/pay
Content-Type: application/json
Authorization: Bearer {token}

请求：
{
  "order_no": "ORD20260417001",
  "channel": "paypal",
  "amount": 9.99,
  "currency": "USD"
}

响应：
{
  "code": 0,
  "data": {
    "order_no": "ORD20260417001",
    "pay_params": {
      "paypal_order_id": "5O190127TN364715T",
      "approve_url": "https://www.paypal.com/checkout..."
    }
  }
}
```

完整 API 文档请查看：[docs/API.md](docs/API.md)

---

## 📅 开发路线图

| 阶段 | 时间 | 里程碑 | 状态 |
|------|------|--------|------|
| **第一阶段** | 1-3 月 | 环境搭建、框架初始化、支付资质申请 | 📋 计划中 |
| **第二阶段** | 4-6 月 | 核心功能开发、支付渠道对接 | 📋 计划中 |
| **第三阶段** | 7-8 月 | 测试优化、APP 上架、部署 | 📋 计划中 |
| **第四阶段** | 9 月 | 正式上线、全球推广 | 📋 计划中 |
| **第五阶段** | 10-12 月 | 规模化扩张、功能升级、优化 | 📋 计划中 |

### 核心指标（KPI）

| 指标 | 目标值 |
|------|--------|
| 接口响应时间 | ≤ 3s |
| 支付成功率 | ≥ 95% |
| 系统可用性 | ≥ 99.9% |
| 视频加载时间 | ≤ 2s |
| 用户付费转化率 | ≥ 15% |

---

## 🤝 贡献指南

我们欢迎各种形式的贡献！详见 [贡献指南](CONTRIBUTING.md)。

### 如何贡献

1. **Fork** 本仓库
2. **创建** 特性分支（`git checkout -b feature/AmazingFeature`）
3. **提交** 更改（`git commit -m 'feat: 添加新功能'`）
4. **推送** 到分支（`git push origin feature/AmazingFeature`）
5. **开启** Pull Request

### 开发流程

```bash
# 1. Fork 并克隆
git clone https://github.com/zsbai780518/dramahub.git
cd dramahub

# 2. 创建特性分支
git checkout -b feature/your-feature

# 3. 修改并提交
git add .
git commit -m "feat: 添加新功能"

# 4. 推送并创建 PR
git push origin feature/your-feature
```

### 代码规范

我们遵循 PSR-12 PHP 编码规范。请确保：
- 使用正确的命名规范
- 函数和类包含注释文档
- 通过 PHP CS Fixer 检查
- 新功能包含单元测试

---

## 📄 开源协议

本项目采用 **MIT 协议**开源 - 详见 [LICENSE](LICENSE) 文件。

```
MIT License

Copyright (c) 2026 DramaHub

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 📞 联系与支持

- **仓库：** https://github.com/zsbai780518/dramahub
- **问题反馈：** https://github.com/zsbai780518/dramahub/issues
- **邮箱：** support@dramahub.com
- **文档：** https://github.com/zsbai780518/dramahub/wiki

---

## 🙏 致谢

感谢以下开源项目：

- [ThinkPHP](https://www.thinkphp.cn/) - PHP 开发框架
- [UniApp](https://uniapp.dcloud.net.cn/) - 跨端开发框架
- [PayPal SDK](https://developer.paypal.com/) - PayPal 支付
- [微信支付](https://pay.weixin.qq.com/) - 微信支付 API

---

## ⚠️ 免责声明

本项目仅供**学习和参考使用**。

商业部署请确保：
- ✅ 办理相关营业执照和许可证
- ✅ 遵守当地支付监管规定
- ✅ 完成内容发行备案
- ✅ 遵循 GDPR、CCPA 等数据隐私法规
- ✅ 实施适当的安全措施

**作者不对商业使用产生的任何法律问题负责。**

---

<div align="center">

**DramaHub 团队 ❤️ 制作**

[⬆ 返回顶部](#dramahub---海外短视频短剧发行平台)

</div>
