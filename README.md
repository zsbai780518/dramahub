# 🎬 DramaHub

**Overseas Short Drama Distribution Platform | 海外短视频短剧发行平台**

---

## 🌐 Language / 语言选择

<div align="center">

[🇨🇳 **中文版本**](#中文) | [🇺🇸 **English Version**](#english)

---

</div>

<a name="english"></a>

## 🇺🇸 English Version

> 🎬 Global one-stop short drama paid distribution platform with integrated payment gateway supporting PayPal, Stripe, WeChat Pay, and Alipay.

### ✨ Key Features

| Feature | Description |
|---------|-------------|
| 💳 **Global Payment** | PayPal, Stripe, WeChat Pay Int'l, Alipay Int'l |
| 📱 **Multi-Platform** | iOS App, Android App, H5 Web (UniApp) |
| 🎯 **Complete Ecosystem** | Content upload, review, distribution, payment, profit sharing |
| 🛡️ **Compliance Ready** | GDPR, CCPA compliant |

### 🏗️ Tech Stack

```
Backend:  LAMP + ThinkPHP6 + MySQL 8.0 + Redis 6.0
Frontend: UniApp (iOS + Android + H5)
Payment:  PayPal + Stripe + WeChat Pay + Alipay
```

### 📁 Project Structure

```
dramahub/
├── backend/           # ThinkPHP 6 Backend
│   ├── app/          # Application Logic
│   ├── extend/       # Payment Gateway
│   └── config/       # Configuration
├── frontend/          # UniApp Frontend
│   ├── pages/        # Pages
│   ├── components/   # Components
│   └── api/          # API Client
└── docs/             # Documentation
```

### 🚀 Quick Start

```bash
# 1. Clone repository
git clone https://github.com/zsbai780518/dramahub.git
cd dramahub

# 2. Backend Setup
cd backend
composer install
mysql -u root -p dramahub < database.sql

# 3. Frontend Setup
cd ../frontend
npm install
npm run dev:h5
```

### 💳 Payment System

| Channel | Regions | Status |
|---------|---------|--------|
| **PayPal** | 200+ countries | ✅ Ready |
| **WeChat Pay Int'l** | 200+ countries | ✅ Ready |
| **Alipay Int'l** | Global | ✅ Ready |
| **Stripe** | Global | ⏳ TODO |

### 📊 Development Roadmap

| Phase | Timeline | Status |
|-------|----------|--------|
| Phase 1 | Month 1-3 | 📋 Planned |
| Phase 2 | Month 4-6 | 📋 Planned |
| Phase 3 | Month 7-8 | 📋 Planned |
| Phase 4 | Month 9 | 📋 Planned |
| Phase 5 | Month 10-12 | 📋 Planned |

### 📖 Documentation

- 📄 **[Full English Docs](README_EN.md)** - Complete documentation
- 📄 **[中文文档](README_CN.md)** - 完整中文文档
- 📄 **[API Docs](docs/API.md)** - API reference
- 📄 **[Contributing Guide](CONTRIBUTING.md)** - How to contribute

### 🔗 Quick Links

| Resource | Link |
|----------|------|
| 🌐 Website | [Visit Demo](https://dramahub.com) |
| 📚 Docs | [Documentation](https://github.com/zsbai780518/dramahub/wiki) |
| 🐛 Issues | [Issue Tracker](https://github.com/zsbai780518/dramahub/issues) |
| 💬 Discussion | [GitHub Discussions](https://github.com/zsbai780518/dramahub/discussions) |

### 📞 Contact

- **Email:** support@dramahub.com
- **GitHub:** https://github.com/zsbai780518/dramahub

---

<div align="center">

[⬆ Back to Top](#-dramahub) | [🇨🇳 切换到中文](#中文)

---

</div>

<a name="中文"></a>

## 🇨🇳 中文版本

> 🎬 全球化一站式短视频短剧付费发行平台，支持 PayPal、Stripe、微信支付国际版、支付宝国际收单。

### ✨ 核心功能

| 功能 | 说明 |
|------|------|
| 💳 **全球支付** | PayPal、Stripe、微信支付、支付宝 |
| 📱 **多端覆盖** | iOS APP、Android APP、H5 网页（UniApp） |
| 🎯 **完整生态** | 内容上传、审核、分发、付费、分润 |
| 🛡️ **合规就绪** | 遵循 GDPR、CCPA 国际法规 |

### 🏗️ 技术架构

```
后端：LAMP + ThinkPHP6 + MySQL 8.0 + Redis 6.0
前端：UniApp（iOS + Android + H5）
支付：PayPal + Stripe + 微信支付 + 支付宝
```

### 📁 项目结构

```
dramahub/
├── backend/           # ThinkPHP 6 后端
│   ├── app/          # 应用逻辑
│   ├── extend/       # 支付网关
│   └── config/       # 配置文件
├── frontend/          # UniApp 前端
│   ├── pages/        # 页面
│   ├── components/   # 组件
│   └── api/          # API 接口
└── docs/             # 文档目录
```

### 🚀 快速开始

```bash
# 1. 克隆项目
git clone https://github.com/zsbai780518/dramahub.git
cd dramahub

# 2. 后端配置
cd backend
composer install
mysql -u root -p dramahub < database.sql

# 3. 前端配置
cd ../frontend
npm install
npm run dev:h5
```

### 💳 支付体系

| 渠道 | 覆盖地区 | 状态 |
|------|----------|------|
| **PayPal** | 200+ 国家 | ✅ 就绪 |
| **微信支付国际版** | 200+ 国家 | ✅ 就绪 |
| **支付宝国际收单** | 全球 | ✅ 就绪 |
| **Stripe** | 全球 | ⏳ 待开发 |

### 📅 开发路线图

| 阶段 | 时间 | 状态 |
|------|------|------|
| 第一阶段 | 1-3 月 | 📋 计划中 |
| 第二阶段 | 4-6 月 | 📋 计划中 |
| 第三阶段 | 7-8 月 | 📋 计划中 |
| 第四阶段 | 9 月 | 📋 计划中 |
| 第五阶段 | 10-12 月 | 📋 计划中 |

### 📖 文档链接

- 📄 **[完整英文文档](README_EN.md)** - Full English documentation
- 📄 **[完整中文文档](README_CN.md)** - 完整中文文档
- 📄 **[API 文档](docs/API.md)** - API 接口文档
- 📄 **[贡献指南](CONTRIBUTING.md)** - 如何贡献代码

### 🔗 快速链接

| 资源 | 链接 |
|------|------|
| 🌐 官网 | [访问演示](https://dramahub.com) |
| 📚 文档 | [在线文档](https://github.com/zsbai780518/dramahub/wiki) |
| 🐛 问题反馈 | [Issue 追踪](https://github.com/zsbai780518/dramahub/issues) |
| 💬 讨论区 | [GitHub 讨论区](https://github.com/zsbai780518/dramahub/discussions) |

### 📞 联系方式

- **邮箱：** support@dramahub.com
- **GitHub：** https://github.com/zsbai780518/dramahub

---

<div align="center">

[⬆ 返回顶部](#-dramahub) | [🇺🇸 Switch to English](#english)

---

</div>

## 📊 项目统计 | Project Stats

| 指标 Metric | 数值 Count |
|------------|-----------|
| 📁 文件 Files | 18+ |
| 💻 代码行数 Lines of Code | 3000+ |
| 🌟 提交 Commits | 5+ |
| 📦 语言 Languages | PHP, JavaScript, SQL, Markdown |

## 🛡️ 安全提示 | Security Notice

**⚠️ 重要 | Important:**

请勿将 API 密钥、数据库密码等敏感信息提交到代码仓库。

Do NOT commit sensitive information like API keys, database passwords to the repository.

## 📄 开源协议 | License

This project is open-sourced under the **MIT License** - see the [LICENSE](LICENSE) file for details.

本项目采用 **MIT 协议**开源 - 详见 [LICENSE](LICENSE) 文件。

---

<div align="center">

**Made with ❤️ by the DramaHub Team**

[English](#english) | [中文](#中文)

**Star ⭐ this repository if you find it helpful!**

</div>
