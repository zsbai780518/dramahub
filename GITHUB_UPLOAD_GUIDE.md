# GitHub 上传指南 | GitHub Upload Guide

## 📋 步骤 | Steps

### 方法一：使用 Git 命令行 | Method 1: Using Git CLI

#### 中文步骤

```bash
# 1. 进入项目目录
cd /home/admin/openclaw/workspace/海外短剧发行平台

# 2. 在 GitHub 创建新仓库
# 访问：https://github.com/new
# 仓库名称：dramahub
# 描述：全球化一站式短视频短剧付费发行平台
# ⚠️ 不要勾选 "Initialize this repository with a README"

# 3. 关联远程仓库（替换 YOUR_USERNAME 为你的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/dramahub.git

# 4. 推送到 GitHub
git branch -M main
git push -u origin main

# 5. 完成！访问你的仓库
# https://github.com/YOUR_USERNAME/dramahub
```

#### English Steps

```bash
# 1. Navigate to project directory
cd /home/admin/openclaw/workspace/海外短剧发行平台

# 2. Create new repository on GitHub
# Visit: https://github.com/new
# Repository name: dramahub
# Description: Global one-stop short drama paid distribution platform
# ⚠️ Do NOT check "Initialize this repository with a README"

# 3. Add remote repository (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/dramahub.git

# 4. Push to GitHub
git branch -M main
git push -u origin main

# 5. Done! Visit your repository
# https://github.com/YOUR_USERNAME/dramahub
```

---

### 方法二：使用 GitHub Desktop | Method 2: Using GitHub Desktop

#### 中文步骤

1. **下载并安装 GitHub Desktop**
   - 访问：https://desktop.github.com/
   - 下载并安装

2. **登录 GitHub**
   - 打开 GitHub Desktop
   - 使用你的 GitHub 账号登录

3. **添加本地仓库**
   - 点击 `File` → `Add local repository`
   - 选择项目目录：`/home/admin/openclaw/workspace/海外短剧发行平台`
   - 点击 `Add repository`

4. **发布到 GitHub**
   - 点击右上角 `Publish repository`
   - 填写仓库信息：
     - **Name:** dramahub
     - **Description:** 全球化一站式短视频短剧付费发行平台 | Global one-stop short drama paid distribution platform
     - **Public:** ✅ (公开)
   - 点击 `Publish repository`

5. **完成！**
   - 访问：https://github.com/YOUR_USERNAME/dramahub

#### English Steps

1. **Download and install GitHub Desktop**
   - Visit: https://desktop.github.com/
   - Download and install

2. **Login to GitHub**
   - Open GitHub Desktop
   - Login with your GitHub account

3. **Add local repository**
   - Click `File` → `Add local repository`
   - Choose project directory: `/home/admin/openclaw/workspace/海外短剧发行平台`
   - Click `Add repository`

4. **Publish to GitHub**
   - Click `Publish repository` at top right
   - Fill in repository details:
     - **Name:** dramahub
     - **Description:** 全球化一站式短视频短剧付费发行平台 | Global one-stop short drama paid distribution platform
     - **Public:** ✅
   - Click `Publish repository`

5. **Done!**
   - Visit: https://github.com/YOUR_USERNAME/dramahub

---

## 🔧 后续配置 | Post-Setup Configuration

### 1. 添加 Topics 标签 | Add Topics

在 GitHub 仓库页面，点击 `Manage topics`，添加以下标签：

```
thinkphp6 uniapp short-drama payment-gateway wechat-pay paypal lamp
video-streaming php-mysql cross-border-ecommerce content-platform
短剧 短视频 出海 支付网关 UniApp ThinkPHP
```

### 2. 启用 GitHub 功能 | Enable GitHub Features

进入 `Settings` → `Features`，启用：

| 功能 | Feature | 建议 | Recommendation |
|------|---------|------|----------------|
| Issues | 问题追踪 | ✅ 启用 | ✅ Enable |
| Projects | 项目管理看板 | ✅ 启用 | ✅ Enable |
| Wiki | 文档 | ✅ 启用 | ✅ Enable |
| Discussions | 讨论区 | ✅ 启用 | ✅ Enable |
| Pages | 静态网站 | ⏳ 可选 | ⏳ Optional |

### 3. 设置分支保护 | Set Branch Protection

进入 `Settings` → `Branches` → `Add branch protection rule`：

- **Branch name pattern:** `main`
- ✅ **Require a pull request before merging** (合并前需要 PR)
- ✅ **Require status checks to pass before merging** (状态检查通过前禁止合并)

### 4. 添加仓库徽章 | Add Repository Badges

将以下徽章添加到 README.md 顶部：

```markdown
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![PHP](https://img.shields.io/badge/PHP-8.1+-blue.svg)](https://www.php.net/)
[![ThinkPHP](https://img.shields.io/badge/ThinkPHP-6.0-blue.svg)](https://www.thinkphp.cn/)
[![UniApp](https://img.shields.io/badge/UniApp-1.x-green.svg)](https://uniapp.dcloud.net.cn/)
[![Issues](https://img.shields.io/github/issues/YOUR_USERNAME/dramahub)](https://github.com/YOUR_USERNAME/dramahub/issues)
[![Stars](https://img.shields.io/github/stars/YOUR_USERNAME/dramahub)](https://github.com/YOUR_USERNAME/dramahub/stargazers)
```

---

## 📊 项目统计 | Project Stats

### 文件统计 | File Statistics

| 类型 | Type | 数量 | Count |
|------|------|------|-------|
| PHP 文件 | PHP Files | 3 | 3 |
| 配置文件 | Config Files | 3 | 3 |
| 文档文件 | Documentation | 8 | 8 |
| SQL 脚本 | SQL Scripts | 1 | 1 |
| **总计** | **Total** | **16** | **16** |

### 代码统计 | Code Statistics

```bash
# 查看代码行数
cd /home/admin/openclaw/workspace/海外短剧发行平台
find . -name "*.php" -o -name "*.sql" -o -name "*.md" | xargs wc -l
```

---

## 🎯 推荐后续操作 | Recommended Next Steps

### 1. 完善 GitHub Pages | Set up GitHub Pages

```bash
# 如果有前端演示页面，可以启用 GitHub Pages
# Settings → Pages → Source: main branch /docs folder
```

### 2. 配置 CI/CD | Configure CI/CD

- GitHub Actions 已配置在 `.github/workflows/ci.yml`
- 需要在仓库设置中添加 Secrets：
  - `DOCKER_USERNAME` - Docker Hub 用户名
  - `DOCKER_PASSWORD` - Docker Hub 密码/Token

### 3. 添加演示视频 | Add Demo Video

- 录制平台使用视频
- 上传到 YouTube 或 Bilibili
- 在 README 中嵌入视频链接

### 4. 创建 Release | Create Release

```bash
# 创建第一个正式版本
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin --tags
```

---

## ❓ 常见问题 | FAQ

### Q1: 推送失败怎么办？ | Q1: What if push fails?

**中文：**
```bash
# 检查远程仓库地址
git remote -v

# 如果错误，删除并重新添加
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/dramahub.git

# 再次推送
git push -u origin main
```

**English：**
```bash
# Check remote repository URL
git remote -v

# If wrong, remove and re-add
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/dramahub.git

# Push again
git push -u origin main
```

### Q2: 如何更新代码？ | Q2: How to update code?

**中文：**
```bash
# 修改代码后
git add .
git commit -m "feat: 更新说明 | Update description"
git push origin main
```

**English：**
```bash
# After modifying code
git add .
git commit -m "feat: Update description"
git push origin main
```

### Q3: 如何邀请协作者？ | Q3: How to invite collaborators?

**中文：**
1. 进入仓库 `Settings`
2. 点击 `Collaborators`
3. 点击 `Add people`
4. 输入对方的 GitHub 用户名或邮箱

**English：**
1. Go to repository `Settings`
2. Click `Collaborators`
3. Click `Add people`
4. Enter collaborator's GitHub username or email

---

## 📞 需要帮助？ | Need Help?

- 📧 邮箱 | Email: support@dramahub.com
- 💬 GitHub Issues: https://github.com/YOUR_USERNAME/dramahub/issues
- 📖 文档 | Docs: https://github.com/YOUR_USERNAME/dramahub/wiki

---

**祝你好运！| Good Luck! 🚀**
