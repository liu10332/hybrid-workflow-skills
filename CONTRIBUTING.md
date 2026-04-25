# 贡献指南

感谢你对Hybrid Workflow Skills项目的关注！我们欢迎各种形式的贡献。

## 如何贡献

### 报告问题

1. 使用 [Issue模板](.github/ISSUE_TEMPLATE/) 创建新Issue
2. 描述问题的详细信息
3. 提供复现步骤（如果适用）
4. 添加相关标签

### 提交代码

1. Fork本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建Pull Request

### 改进文档

1. 发现文档错误或不清楚的地方
2. 直接修改文档文件
3. 提交Pull Request

## 开发规范

### 代码风格

- 使用UTF-8编码
- 使用2空格缩进（对于Markdown文件）
- 遵循现有代码风格

### 提交信息

使用清晰的提交信息格式：

```
<类型>(<范围>): <描述>

[可选正文]

[可选脚注]
```

类型包括：
- `feat`: 新功能
- `fix`: 修复bug
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动

### 技能文件规范

- 每个技能必须包含`SKILL.md`主文档
- 使用YAML frontmatter格式
- 包含完整的使用说明和示例
- 提供相关技能的链接

## 开发流程

### 1. 设置开发环境

```bash
# 克隆仓库
git clone https://github.com/your-username/hybrid-workflow-skills.git

# 进入目录
cd hybrid-workflow-skills

# 安装依赖（如果有）
./scripts/install.sh
```

### 2. 进行更改

- 修改技能文件或文档
- 确保所有链接有效
- 测试示例代码（如果适用）

### 3. 测试更改

```bash
# 验证技能文件格式
./scripts/validate.sh

# 测试示例（如果有）
cd examples/simple-web-app
./run.sh
```

### 4. 提交更改

```bash
# 添加更改
git add .

# 提交
git commit -m "feat: 添加新技能示例"

# 推送
git push origin feature/your-feature
```

### 5. 创建Pull Request

1. 访问你的Fork仓库
2. 点击"New Pull Request"
3. 填写PR模板
4. 等待审查

## 技能开发指南

### 创建新技能

1. 在`skills/`目录下创建新目录
2. 创建`SKILL.md`主文档
3. 添加必要的脚本和资源
4. 编写使用文档
5. 提供示例（如果适用）

### 技能文档结构

```markdown
---
name: skill-name
description: "技能描述"
version: 1.0.0
author: 作者名
license: MIT
metadata:
  hermes:
    tags: [tag1, tag2]
    related_skills: [skill1, skill2]
---

# 技能名称

## 概述
技能的基本介绍

## 使用场景
什么时候使用这个技能

## 命令/方法
具体的命令或方法

## 示例
使用示例

## 相关技能
相关技能的链接
```

## 社区准则

- 尊重所有参与者
- 建设性地提出意见
- 帮助新手入门
- 保持专业和友好

## 许可证

通过贡献，你同意你的贡献将在MIT许可证下发布。

## 联系方式

- 创建Issue讨论问题
- 参与Pull Request审查
- 加入社区讨论（如果有）

感谢你的贡献！🎉