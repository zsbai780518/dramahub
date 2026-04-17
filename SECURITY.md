# 安全政策

## 报告安全问题

如果你发现本项目存在安全漏洞，请负责任地披露：

### 📧 联系方式

- 邮箱：security@dramahub.com
- GitHub Security Advisories: [创建私密报告](https://github.com/YOUR_USERNAME/dramahub/security/advisories)

### 📋 报告内容

请提供以下信息：

1. **漏洞类型**（如 SQL 注入、XSS、CSRF 等）
2. **受影响版本**
3. **复现步骤**（详细说明如何触发漏洞）
4. **潜在影响**（可能造成的危害）
5. **修复建议**（如有）

### ⏰ 响应时间

- **确认收到报告：** 3 个工作日内
- **漏洞评估：** 5 个工作日内
- **修复方案：** 根据严重程度 7-30 天
- **公开披露：** 修复发布后

### 🛡️ 已知安全问题

| 问题 | 状态 | 修复版本 |
|------|------|----------|
| - | - | - |

## 安全最佳实践

### 部署建议

1. **使用 HTTPS**
   - 生产环境必须启用 HTTPS
   - 使用 Let's Encrypt 或商业 SSL 证书

2. **数据库安全**
   - 不要使用 root 用户
   - 设置强密码
   - 限制远程访问

3. **支付安全**
   - 妥善保管 API 密钥
   - 不要将密钥提交到代码仓库
   - 定期轮换密钥

4. **文件权限**
   ```bash
   # 设置正确的目录权限
   chmod -R 755 /path/to/dramahub
   chmod -R 777 /path/to/dramahub/runtime
   chmod -R 777 /path/to/dramahub/public/uploads
   ```

5. **定期更新**
   - 及时更新 ThinkPHP 框架
   - 更新 PHP 到最新安全版本
   - 更新依赖包

### 代码安全

- 所有用户输入必须验证和过滤
- 使用参数化查询防止 SQL 注入
- 输出时进行 HTML 转义防止 XSS
- 表单提交使用 CSRF Token
- 敏感操作需要二次验证

## 安全更新

本项目会通过以下方式发布安全更新：

- GitHub Releases 发布安全公告
- GitHub Security Advisories 披露漏洞详情
- 更新日志中标注安全修复

## 致谢

感谢以下安全研究者：

- （待添加）

---

**注意：** 请勿在生产环境测试安全漏洞，这可能导致数据丢失或服务中断。
