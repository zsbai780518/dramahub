# 贡献指南

感谢你对 DramaHub 项目的关注！我们欢迎各种形式的贡献，包括但不限于：

- 🐛 报告 Bug
- 💡 提出新功能建议
- 📝 改进文档
- 🔧 提交代码修复或新功能
- 🌍 翻译国际化内容

## 🐛 报告 Bug

在报告 Bug 之前，请确认：

1. 已经搜索过现有的 Issues，没有重复报告
2. 使用的是最新版本
3. 能够稳定复现该问题

### Bug 报告模板

```markdown
**问题描述**
简要描述问题是什么

**复现步骤**
1. 步骤 1
2. 步骤 2
3. 步骤 3

**期望行为**
描述你期望发生什么

**实际行为**
描述实际发生了什么

**环境信息**
- PHP 版本：x.x.x
- MySQL 版本：x.x.x
- 服务器系统：Linux/Windows
- 浏览器（如适用）：Chrome/Firefox/Safari

**截图**
如适用，添加截图帮助说明问题
```

## 💡 提出新功能

新功能建议请创建 Issue，并说明：

- 功能的使用场景
- 期望的实现方式
- 是否有类似的参考实现

## 🔧 提交代码

### 开发流程

1. **Fork 仓库**
   - 点击 GitHub 页面右上角的 Fork 按钮

2. **克隆仓库**
   ```bash
   git clone https://github.com/YOUR_USERNAME/dramahub.git
   cd dramahub
   ```

3. **创建分支**
   ```bash
   # 功能开发
   git checkout -b feature/your-feature-name
   
   # Bug 修复
   git checkout -b fix/issue-123
   ```

4. **开发并提交**
   ```bash
   git add .
   git commit -m "feat: 添加新功能"  # 或 "fix: 修复某个问题"
   ```

5. **推送分支**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **创建 Pull Request**
   - 在 GitHub 上进入你的 Fork 仓库
   - 点击 "Compare & pull request"
   - 填写 PR 描述，关联相关 Issue

### 代码规范

#### PHP 代码规范

遵循 PSR-12 编码规范：

```php
<?php
// 命名空间声明在文件顶部
namespace App\Controller;

// 类名使用 PascalCase
class UserController
{
    // 方法名使用 camelCase
    public function getUserInfo()
    {
        // 变量名使用 camelCase
        $userInfo = [];
        
        // 控制结构关键字后加空格
        if (empty($userInfo)) {
            return null;
        }
        
        return $userInfo;
    }
}
```

#### 注释规范

```php
/**
 * 获取用户信息
 * 
 * @param int $userId 用户 ID
 * @return array|null 用户信息数组，失败返回 null
 * @throws \Exception 当数据库查询失败时抛出
 */
public function getUserInfo(int $userId): ?array
{
    // ...
}
```

#### Git Commit 信息规范

遵循 [Conventional Commits](https://www.conventionalcommits.org/) 规范：

- `feat:` 新功能
- `fix:` Bug 修复
- `docs:` 文档更新
- `style:` 代码格式调整（不影响功能）
- `refactor:` 代码重构（既不是新功能也不是 Bug 修复）
- `perf:` 性能优化
- `test:` 测试相关
- `chore:` 构建过程或辅助工具变动

示例：
```bash
git commit -m "feat: 添加 PayPal 支付渠道支持"
git commit -m "fix: 修复微信支付回调签名验证问题"
git commit -m "docs: 更新 API 接口文档"
```

### 代码审查清单

提交 PR 前请自查：

- [ ] 代码已通过本地测试
- [ ] 遵循项目代码规范
- [ ] 添加了必要的注释
- [ ] 更新了相关文档
- [ ] Commit 信息清晰规范
- [ ] PR 描述完整（说明改动内容、关联 Issue）

## 📝 文档贡献

文档改进同样重要！包括：

- 修正错别字或语法错误
- 补充缺失的说明
- 添加示例代码
- 改进翻译质量

## 🌍 国际化

欢迎帮助翻译项目到不同语言！

在 `frontend/locale/` 目录下添加或更新语言文件：

```javascript
// locale/ja-JP.js
export default {
  common: {
    confirm: '確認',
    cancel: 'キャンセル',
    // ...
  }
}
```

## 💬 讨论区

有任何问题或想法，欢迎在 [Discussions](https://github.com/YOUR_USERNAME/dramahub/discussions) 中交流！

---

再次感谢你的贡献！🎉
