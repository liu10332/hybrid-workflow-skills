# Simple Web App 示例项目

这是一个使用混合工作流开发的简单Web应用示例。

## 项目概述

一个简单的待办事项（Todo）Web应用，展示混合工作流的完整开发过程。

## 功能特性

- 添加待办事项
- 标记完成/未完成
- 删除待办事项
- 本地存储

## 技术栈

- HTML5
- CSS3
- JavaScript (ES6+)

## 开发流程

### 阶段1：需求分析（brainstorming）

**需求**：
- 用户可以添加待办事项
- 用户可以标记待办事项为完成/未完成
- 用户可以删除待办事项
- 数据在页面刷新后保持

**技术选型**：
- 纯前端实现，无需后端
- 使用localStorage存储数据
- 响应式设计

### 阶段2：设计讨论（discuss-phase）

**决策记录**：
- D-01: 使用localStorage而非数据库
- D-02: 使用简洁的UI设计
- D-03: 支持移动端访问

### 阶段3：任务规划（writing-plans）

**任务分解**：
1. 创建项目结构
2. 实现HTML骨架
3. 添加CSS样式
4. 实现JavaScript逻辑
5. 测试和调试

### 阶段4：TDD执行（test-driven-development）

**测试用例**：
- 测试添加待办事项
- 测试标记完成状态
- 测试删除待办事项
- 测试数据持久化

### 阶段5：代码审查（requesting-code-review）

**审查要点**：
- 代码可读性
- 错误处理
- 性能优化
- 安全性

## 文件结构

```
simple-web-app/
├── README.md          # 项目说明
├── index.html         # 主页面
├── css/
│   └── style.css      # 样式文件
├── js/
│   └── app.js         # 应用逻辑
└── tests/
    └── test.js        # 测试文件
```

## 运行方式

1. 直接打开 `index.html` 文件
2. 或者使用本地服务器：
   ```bash
   # 使用Python
   python -m http.server 8000
   
   # 使用Node.js
   npx serve .
   ```

## 混合工作流演示

本项目展示了混合工作流的完整流程：

1. **brainstorming**: 确定需求和技术选型
2. **discuss-phase**: 讨论设计决策
3. **writing-plans**: 分解任务为小步骤
4. **test-driven-development**: 编写测试用例
5. **subagent-driven-development**: 并行开发不同模块
6. **requesting-code-review**: 代码审查和改进

## 学习要点

- 如何将大任务分解为小步骤
- 如何使用TDD保证代码质量
- 如何进行有效的代码审查
- 如何管理项目状态

## 扩展建议

- 添加更多功能（编辑、分类、优先级）
- 添加后端API支持
- 添加用户认证
- 部署到云平台