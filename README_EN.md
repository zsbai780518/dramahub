# DramaHub - Overseas Short Drama Distribution Platform

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![PHP](https://img.shields.io/badge/PHP-8.1+-blue.svg)](https://www.php.net/)
[![ThinkPHP](https://img.shields.io/badge/ThinkPHP-6.0-blue.svg)](https://www.thinkphp.cn/)
[![UniApp](https://img.shields.io/badge/UniApp-1.x-green.svg)](https://uniapp.dcloud.net.cn/)

> 🎬 Global one-stop short drama paid distribution platform with integrated payment gateway supporting PayPal, Stripe, WeChat Pay, and Alipay.

---

## 📖 Table of Contents

- [Introduction](#-introduction)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Payment System](#-payment-system)
- [Project Structure](#-project-structure)
- [Quick Start](#-quick-start)
- [API Documentation](#-api-documentation)
- [Development Roadmap](#-development-roadmap)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🌟 Introduction

DramaHub is a comprehensive B2B2C platform designed for the global short drama market. It provides end-to-end solutions for content distribution, monetization, and user management.

**Key Highlights:**
- 🌍 **Global Payment Support** - PayPal, Stripe, WeChat Pay International, Alipay International
- 📱 **Multi-Platform** - iOS App, Android App, H5 Web (built with UniApp)
- 🎯 **Complete Ecosystem** - Content upload, review, distribution, payment, profit sharing
- 🛡️ **Compliance Ready** - GDPR, CCPA compliant

**Target Users:**
- **B-End:** Short drama production companies, MCN agencies, content creators
- **C-End:** Global users (North America, Europe, Southeast Asia, Middle East, Latin America)

---

## ✨ Features

### C-End User Platform

| Feature | Description |
|---------|-------------|
| 👤 User Authentication | Email, Phone, Google, Facebook, WeChat, Alipay login |
| 🎬 Content Discovery | Categories, Recommendations, Search, Trending |
| 📺 Video Player | Try-before-buy (3-5 min), Multi-quality, Multi-language subtitles |
| 💳 Payment Center | Single episode, Full series, Subscription, Recharge packages |
| 👤 User Profile | Membership, Order history, Wallet, Watch history |

### B-End Content Provider Platform

| Feature | Description |
|---------|-------------|
| 📝 Provider Onboarding | Application, Verification, Approval workflow |
| 📤 Content Management | Upload, Edit, Publish, Schedule |
| 📊 Analytics | Views, Conversion rate, Revenue, User demographics |
| 💰 Profit & Withdrawal | Profit sharing, Withdrawal requests, Transaction history |

### Admin Platform

| Feature | Description |
|---------|-------------|
| 👥 User Management | C-end users, B-end providers, Roles & Permissions |
| 🎬 Content Moderation | AI + Manual review, Copyright protection |
| 💳 Order & Payment | Order tracking, Payment channels, Reconciliation |
| 📈 Operations | Campaigns, Push notifications, Ad management |
| ⚙️ System Settings | Multi-language, Configurations, Audit logs |

---

## 🏗️ Tech Stack

### Backend

```
┌─────────────────────────────────────────┐
│           Application Layer             │
│         (ThinkPHP 6.0 MVC)              │
├─────────────────────────────────────────┤
│           Business Logic                │
│   User | Content | Order | Payment      │
├─────────────────────────────────────────┤
│            Data Layer                   │
│   MySQL 8.0 (Master-Slave) + Redis      │
├─────────────────────────────────────────┤
│          Infrastructure                 │
│   LAMP (Linux + Apache + MySQL + PHP)   │
└─────────────────────────────────────────┘
```

**Core Technologies:**
- **Server:** Linux (CentOS 7.6+ / Ubuntu 20.04+)
- **Web Server:** Apache 2.4+ with mod_rewrite
- **Database:** MySQL 8.0 (Master-Slave replication)
- **Cache:** Redis 6.0+
- **Language:** PHP 8.1+
- **Framework:** ThinkPHP 6.0 LTS

### Frontend

```
┌─────────────────────────────────────────┐
│           UniApp Framework              │
│      (Write Once, Run Anywhere)         │
├──────────┬──────────────┬───────────────┤
│  iOS App │ Android App  │    H5 Web     │
└──────────┴──────────────┴───────────────┘
```

**Core Technologies:**
- **Framework:** UniApp (Vue.js based)
- **Multi-Platform:** iOS, Android, H5
- **State Management:** Vuex
- **Internationalization:** i18n (6 languages)
- **Video Player:** Native + HLS support

### Third-Party Services

| Service | Provider | Purpose |
|---------|----------|---------|
| Object Storage | Aliyun OSS / Tencent COS | Video storage |
| CDN | Global CDN | Video delivery |
| SMS | Twilio / Aliyun | Verification codes |
| Push Notification | Firebase / JPush | App notifications |
| Content Moderation | Third-party AI | Content review |

---

## 💳 Payment System

### Global Payment Channels

| Channel | Regions | Currencies | Status |
|---------|---------|------------|--------|
| **PayPal** | 200+ countries | USD, EUR, GBP, etc. | ✅ Ready |
| **Stripe** | Global | Credit Cards | ⏳ TODO |
| **Google Pay** | Global | Local currencies | ⏳ TODO |
| **Apple Pay** | Global | Local currencies | ⏳ TODO |

### Regional Payment Channels

| Region | Payment Methods |
|--------|-----------------|
| 🇺🇸🇪🇺 North America & Europe | PayPal, Stripe, Credit Cards |
| 🇸🇬🇹🇭🇮🇩 Southeast Asia | GoPay, Dana, Touch'n Go, GCash |
| 🇸🇦🇦🇪 Middle East | Fawry, Mada, PayFort |
| 🇧🇷🇲🇽 Latin America | Pix, Mercado Pago |

### Cross-Border Payment (Core Feature)

| Channel | Description | Status |
|---------|-------------|--------|
| **WeChat Pay International** | 200+ countries, supports foreign cards | ✅ Ready |
| **Alipay International** | Global Alipay users, real-time FX | ✅ Ready |

### Payment Gateway Architecture

```
┌─────────────────────────────────────────────────────────┐
│                  Payment Gateway                        │
├─────────────┬─────────────┬─────────────┬───────────────┤
│   PayPal    │   Stripe    │ WeChat Pay  │   Alipay      │
├─────────────┴─────────────┴─────────────┴───────────────┤
│              Unified Payment Interface                   │
├─────────────────────────────────────────────────────────┤
│  Order Management | FX Conversion | Risk Control        │
└─────────────────────────────────────────────────────────┘
```

**Key Features:**
- 🔄 Multi-currency support with real-time exchange rates
- 🛡️ Fraud detection and risk control
- 📊 Automatic reconciliation and settlement
- 💸 Refund processing (original payment method)
- 🔐 PCI DSS compliant

---

## 📁 Project Structure

```
dramahub/
├── backend/                    # ThinkPHP 6 Backend
│   ├── app/
│   │   ├── controller/        # API Controllers
│   │   │   ├── api/          # C-end API
│   │   │   ├── provider/     # B-end Controller
│   │   │   └── admin/        # Admin Controller
│   │   ├── model/            # Database Models
│   │   ├── service/          # Business Logic
│   │   └── validate/         # Validators
│   ├── extend/payment/       # Payment Gateway
│   │   ├── PaymentGateway.php
│   │   ├── WechatPay.php
│   │   └── PayPal.php
│   ├── config/               # Configuration
│   ├── public/               # Public Assets
│   └── runtime/              # Runtime Files
├── frontend/                  # UniApp Frontend
│   ├── pages/                # Pages
│   ├── components/           # Components
│   ├── api/                  # API Client
│   ├── utils/                # Utilities
│   ├── store/                # Vuex Store
│   ├── locale/               # i18n Languages
│   └── static/               # Static Assets
├── docs/                      # Documentation
├── .github/                   # GitHub Configuration
│   └── workflows/            # CI/CD Pipeline
├── database.sql               # Database Schema
├── README.md                  # This File
└── LICENSE                    # MIT License
```

---

## 🚀 Quick Start

### Prerequisites

- PHP >= 8.1
- MySQL >= 8.0
- Apache >= 2.4 (with mod_rewrite)
- Redis >= 6.0
- Node.js >= 14 (for frontend)
- Composer >= 2.0
- Git

### Backend Setup

```bash
# 1. Clone the repository
git clone https://github.com/zsbai780518/dramahub.git
cd dramahub/backend

# 2. Install dependencies (if using Composer)
composer install

# 3. Configure database
# Edit config/database.php with your credentials
# Or copy example:
cp config/database.example.php config/database.php

# 4. Import database schema
mysql -u root -p dramahub < database.sql

# 5. Set permissions
chmod -R 777 runtime/
chmod -R 777 public/uploads/

# 6. Configure virtual host (Apache)
# Set 'public' directory as document root
# Enable .htaccess rewrite rules

# 7. Configure payment channels
# Edit config/payment.php with your API credentials
```

### Apache Virtual Host Configuration

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

### Frontend Setup

```bash
# 1. Navigate to frontend directory
cd dramahub/frontend

# 2. Install dependencies
npm install

# 3. Configure API endpoint
# Edit utils/request.js with your backend URL
# const BASE_URL = 'https://api.yourdomain.com'

# 4. Run development server
# H5
npm run dev:h5

# APP
npm run dev:app

# 5. Build for production
npm run build:h5
npm run build:app-android
npm run build:app-ios
```

### Environment Configuration

Create `.env` file in backend root:

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

# Payment Configuration
WECHAT_PAY_APP_ID=your_app_id
WECHAT_PAY_MCH_ID=your_mch_id
WECHAT_PAY_KEY=your_key

PAYPAL_CLIENT_ID=your_client_id
PAYPAL_SECRET=your_secret
PAYPAL_MODE=live
```

---

## 📡 API Documentation

### Authentication Endpoints

```http
POST /api/user/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123",
  "phone": "+1234567890"
}

Response:
{
  "code": 0,
  "msg": "success",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": 1,
      "email": "user@example.com",
      "nickname": "User"
    }
  }
}
```

### Drama Endpoints

```http
GET /api/drama/list?page=1&limit=20&category=1
Authorization: Bearer {token}

Response:
{
  "code": 0,
  "data": {
    "total": 100,
    "list": [
      {
        "id": 1,
        "title": "Sweet Love Story",
        "cover_image": "https://cdn.example.com/cover.jpg",
        "total_episodes": 80,
        "view_count": 150000
      }
    ]
  }
}
```

### Payment Endpoints

```http
POST /api/payment/pay
Content-Type: application/json
Authorization: Bearer {token}

{
  "order_no": "ORD20260417001",
  "channel": "paypal",
  "amount": 9.99,
  "currency": "USD"
}

Response:
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

For complete API documentation, see [docs/API.md](docs/API.md)

---

## 📅 Development Roadmap

| Phase | Timeline | Milestones | Status |
|-------|----------|------------|--------|
| **Phase 1** | Month 1-3 | Environment setup, Framework initialization, Payment资质 | 📋 Planned |
| **Phase 2** | Month 4-6 | Core features development, Payment integration | 📋 Planned |
| **Phase 3** | Month 7-8 | Testing, App store submission, Deployment | 📋 Planned |
| **Phase 4** | Month 9 | Official launch, Global marketing | 📋 Planned |
| **Phase 5** | Month 10-12 | Scaling, Feature enhancement, Optimization | 📋 Planned |

### Key Performance Indicators (KPIs)

| Metric | Target |
|--------|--------|
| API Response Time | ≤ 3s |
| Payment Success Rate | ≥ 95% |
| System Availability | ≥ 99.9% |
| Video Load Time | ≤ 2s |
| User Conversion Rate | ≥ 15% |

---

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### How to Contribute

1. **Fork** the repository
2. **Create** your feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'feat: Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### Development Workflow

```bash
# 1. Fork and clone
git clone https://github.com/zsbai780518/dramahub.git
cd dramahub

# 2. Create feature branch
git checkout -b feature/your-feature

# 3. Make changes and commit
git add .
git commit -m "feat: Add new feature"

# 4. Push and create PR
git push origin feature/your-feature
```

### Code Style

We follow PSR-12 for PHP code. Please ensure your code:
- Uses proper naming conventions
- Includes docblocks for functions and classes
- Passes PHP CS Fixer checks
- Includes unit tests for new features

---

## 📄 License

This project is open-sourced under the **MIT License** - see the [LICENSE](LICENSE) file for details.

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

## 📞 Contact & Support

- **Repository:** https://github.com/zsbai780518/dramahub
- **Issues:** https://github.com/zsbai780518/dramahub/issues
- **Email:** support@dramahub.com
- **Documentation:** https://github.com/zsbai780518/dramahub/wiki

---

## 🙏 Acknowledgments

Thanks to the following open-source projects:

- [ThinkPHP](https://www.thinkphp.cn/) - PHP Framework
- [UniApp](https://uniapp.dcloud.net.cn/) - Cross-platform Framework
- [PayPal SDK](https://developer.paypal.com/) - PayPal Payment
- [WeChat Pay](https://pay.weixin.qq.com/) - WeChat Payment API

---

## ⚠️ Disclaimer

This project is for **educational and reference purposes only**. 

For commercial deployment, please ensure:
- ✅ Obtain necessary business licenses and permits
- ✅ Comply with local payment regulations
- ✅ Complete content distribution licensing
- ✅ Follow GDPR, CCPA, and other data privacy laws
- ✅ Implement proper security measures

**The authors are not responsible for any legal issues arising from commercial use of this software.**

---

<div align="center">

**Made with ❤️ by the DramaHub Team**

[⬆ Back to Top](#-dramahub---overseas-short-drama-distribution-platform)

</div>
