# DramaHub - 海外短视频短剧发行平台

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![PHP](https://img.shields.io/badge/PHP-8.1+-blue.svg)](https://www.php.net/)
[![ThinkPHP](https://img.shields.io/badge/ThinkPHP-6.0-blue.svg)](https://www.thinkphp.cn/)
[![UniApp](https://img.shields.io/badge/UniApp-1.x-green.svg)](https://uniapp.dcloud.net.cn/)

> 🎬 全球化一站式短视频短剧付费发行平台 - 支持海外主流支付 + 微信/支付宝跨境支付

## 🌟 项目简介

DramaHub 是一个面向全球市场的短视频短剧发行平台，为海外短剧内容市场提供完整的 B2B2C 解决方案。

**核心优势：**
- 🌍 **全球化支付** - 支持 PayPal、Stripe 等海外主流支付 + 微信/支付宝跨境支付
- 📱 **多端覆盖** - UniApp 一套代码编译生成 APP（iOS/Android）+ H5
- 🎯 **完整生态** - 内容上传、审核、分发、付费、分润全流程
- 🛡️ **合规安全** - 遵循 GDPR、CCPA 等国际法规

## 🏗️ 技术架构

```
┌─────────────────────────────────────────────────────────────┐
│                      前端展示层                              │
│        UniApp (APP + H5) / 管理后台 (ThinkPHP6)              │
├─────────────────────────────────────────────────────────────┤
│                      接口服务层                              │
│           ThinkPHP6 统一 API 接口 + 鉴权 + 日志               │
├─────────────────────────────────────────────────────────────┤
│                      业务逻辑层                              │
│   用户 | 内容 | 订单 | 支付 | 会员 | 分润 | 风控 | 运营       │
├─────────────────────────────────────────────────────────────┤
│                      数据持久层                              │
│         MySQL 主从 + Redis 缓存 + 海外 OSS 存储               │
├─────────────────────────────────────────────────────────────┤
│                      基础设施层                              │
│      LAMP 环境 + 海外云服务器 + CDN + 网络安全防护            │
└─────────────────────────────────────────────────────────────┘
```

## 📦 功能模块

### C 端用户端（UniApp）
- ✅ 用户注册登录（邮箱/手机/第三方登录）
- ✅ 短剧内容浏览（分类/推荐/搜索）
- ✅ 视频播放（试看/播放控制/画质切换/多语言字幕）
- ✅ 付费中心（单集/全集/会员/礼包/广告 5 种变现模式）
- ✅ 个人中心（会员/订单/资产/观看历史）

### B 端内容方后台
- ✅ 内容方入驻与资质审核
- ✅ 内容上传与管理（视频上传/编辑/发行配置）
- ✅ 内容审核进度追踪
- ✅ 数据统计（播放量/用户画像/收益数据）
- ✅ 分润结算与提现

### 平台运营总后台
- ✅ 用户管理（C 端用户/B 端内容方）
- ✅ 内容管理（审核/分类/版权管控）
- ✅ 订单与支付管理
- ✅ 运营营销（活动/推送/广告位）
- ✅ 系统管理（权限/配置/日志）

## 💳 支付体系

### 海外主流支付
| 渠道 | 覆盖市场 | 状态 |
|------|----------|------|
| PayPal | 全球 200+ 国家 | ✅ |
| Stripe | 欧美信用卡 | ⏳ |
| Google Pay | 全球移动端 | ⏳ |
| Apple Pay | iOS 设备 | ⏳ |

### 区域本地化支付
| 地区 | 支付渠道 |
|------|----------|
| 东南亚 | GoPay、Dana、Touch'n Go、GCash |
| 中东 | Fawry、Mada、PayFort |
| 欧洲 | Sofort、Giropay、iDEAL |
| 拉美 | Pix、Mercado Pago |

### 跨境支付（核心特色）
| 渠道 | 说明 |
|------|------|
| 微信支付国际版 | 覆盖 200+ 国家，支持境外信用卡/国内余额 |
| 支付宝国际收单 | 全球支付宝用户，实时汇率换算 |

## 🚀 快速开始

### 环境要求

- PHP >= 8.1
- MySQL >= 8.0
- Apache >= 2.4 (开启 mod_rewrite)
- Redis >= 6.0
- Node.js >= 14 (前端编译)

### 后端部署

```bash
# 1. 克隆项目
git clone https://github.com/YOUR_USERNAME/dramahub.git
cd dramahub/backend

# 2. 安装 ThinkPHP6（如未包含）
composer install

# 3. 配置数据库
# 复制并修改 config/database.php
cp config/database.example.php config/database.php

# 4. 导入数据库
mysql -u root -p dramahub < database.sql

# 5. 设置目录权限
chmod -R 777 runtime/
chmod -R 777 public/

# 6. 配置虚拟主机（Apache）
# 将 public 目录设置为网站根目录
# 启用 .htaccess 重写规则

# 7. 配置支付渠道
# 修改 config/payment.php 填入各支付渠道参数
```

### 前端部署

```bash
# 1. 进入前端目录
cd dramahub/frontend

# 2. 安装依赖
npm install

# 3. 配置 API 地址
# 修改 utils/request.js 中的 BASE_URL

# 4. 运行开发环境
# H5
npm run dev:h5

# 微信小程序
npm run dev:mp-weixin

# APP
npm run dev:app

# 5. 打包发布
npm run build:h5
npm run build:app-android
npm run build:app-ios
```

## 📁 项目结构

```
dramahub/
├── backend/                    # ThinkPHP6 后端
│   ├── app/
│   │   ├── controller/        # 控制器
│   │   ├── model/             # 模型
│   │   ├── service/           # 业务逻辑
│   │   └── validate/          # 验证器
│   ├── extend/payment/        # 支付网关
│   │   ├── PaymentGateway.php
│   │   ├── WechatPay.php
│   │   └── PayPal.php
│   ├── config/                # 配置文件
│   ├── public/                # 公共目录
│   └── runtime/               # 运行时目录
├── frontend/                   # UniApp 前端
│   ├── pages/                 # 页面
│   ├── components/            # 组件
│   ├── api/                   # API 接口
│   ├── utils/                 # 工具类
│   └── static/                # 静态资源
├── docs/                       # 文档
├── database.sql                # 数据库脚本
├── README.md                   # 本文件
└── LICENSE                     # 开源协议
```

## 📅 开发路线图

| 阶段 | 时间 | 主要任务 | 状态 |
|------|------|----------|------|
| 阶段一 | 1-3 月 | 基础环境搭建、框架初始化 | 📋 |
| 阶段二 | 4-6 月 | 核心功能开发、支付对接 | 📋 |
| 阶段三 | 7-8 月 | 测试优化、APP 上架 | 📋 |
| 阶段四 | 9 月 | 正式上线、全球推广 | 📋 |
| 阶段五 | 10-12 月 | 规模化扩张、功能升级 | 📋 |

## 🤝 贡献指南

欢迎贡献代码！请遵循以下步骤：

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 开源协议

本项目采用 MIT 协议开源 - 查看 [LICENSE](LICENSE) 文件了解详情

## 📞 联系方式

- 项目主页：https://github.com/YOUR_USERNAME/dramahub
- 问题反馈：https://github.com/YOUR_USERNAME/dramahub/issues
- 邮箱：support@dramahub.com

## 🙏 致谢

感谢以下开源项目：

- [ThinkPHP](https://www.thinkphp.cn/) - PHP 开发框架
- [UniApp](https://uniapp.dcloud.net.cn/) - 跨端开发框架
- [PayPal SDK](https://developer.paypal.com/) - PayPal 支付
- [微信支付](https://pay.weixin.qq.com/) - 微信支付 API

---

**⚠️ 免责声明：** 本项目仅供学习参考使用。商业运营请自行办理相关资质（支付牌照、内容发行许可等），并遵守目标市场法律法规。
