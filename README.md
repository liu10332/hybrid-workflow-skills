# Hybrid Workflow Skills

一套完整的AI Agent驱动软件开发工作流技能体系，为结构化项目管理提供方法论支持。

## 🎯 核心特性

- **结构化开发**：里程碑→切片→任务三级管理
- **质量保证**：强制TDD + 两阶段审查
- **状态驱动**：基于文件的状态管理，支持中断恢复
- **咀嚼式执行**：每个任务分解为2-5分钟步骤

## 📦 技能清单

### 核心编排
| 技能 | 描述 |
|------|------|
| [hybrid-workflow](skills/hybrid-workflow/) | 主编排技能，协调切片级任务管理 |
| [hybrid-project-init](skills/hybrid-project-init/) | 项目初始化，从需求到第一个切片 |

### 阶段技能
| 技能 | 描述 |
|------|------|
| [brainstorming](skills/brainstorming/) | 需求分析和设计阶段 |
| [discuss-phase](skills/discuss-phase/) | 切片讨论，收集用户偏好 |
| [writing-plans](skills/writing-plans/) | 任务规划，分解为咀嚼式步骤 |
| [subagent-driven-development](skills/subagent-driven-development/) | 任务执行，子代理并行处理 |
| [test-driven-development](skills/test-driven-development/) | TDD执行，红绿重构循环 |
| [requesting-code-review](skills/requesting-code-review/) | 代码审查，两阶段验证 |

### 支持工具
| 技能 | 描述 |
|------|------|
| [task-workspace](skills/task-workspace/) | 文件组织，版本化项目目录 |
| [efficient-progress-tracking](skills/efficient-progress-tracking/) | 进度追踪，关键节点触发 |

## 🚀 快速开始

### 安装

```bash
# 克隆仓库
git clone https://github.com/liu10332/hybrid-workflow-skills.git

# 进入目录
cd hybrid-workflow-skills

# 运行安装脚本
./scripts/install.sh
```

### 使用

1. **初始化新项目**
```bash
# 使用hybrid-project-init技能
hybrid-project-init "我的项目"
```

2. **执行工作流**
```bash
# 按照混合工作流阶段执行
brainstorming → discuss-phase → writing-plans → subagent-driven-development
```

3. **查看状态**
```bash
# 查看当前项目状态
cat .hybrid/STATE.md
```

## 📚 文档

- [快速开始指南](docs/getting-started.md)
- [核心概念](docs/concepts.md)
- [技能详细文档](docs/skills/)
- [使用示例](docs/examples/)

## 🎯 适用场景

- **个人项目**：需要结构化管理的复杂项目
- **团队协作**：多人参与的软件开发项目
- **开源项目**：需要清晰贡献流程的项目
- **学习项目**：希望掌握最佳实践的开发者

## 🔧 工作流程

```
需求分析 → 设计讨论 → 任务规划 → TDD执行 → 代码审查 → 交付
   ↓           ↓           ↓           ↓           ↓
brainstorming discuss   writing    test-driven  requesting
              phase     plans      development  code-review
```

## 📖 示例项目

- [mihomo-quick](examples/mihomo-quick/) - 代理工具配置管理
- [simple-web-app](examples/simple-web-app/) - 简单Web应用示例

## 🤝 贡献

欢迎贡献！请查看 [CONTRIBUTING.md](CONTRIBUTING.md) 了解详情。

## 📄 许可证

本项目采用 MIT 许可证 - 详情请查看 [LICENSE](LICENSE) 文件。

## 🙏 致谢

- 感谢所有贡献者
- 基于Hermes Agent技能体系
- 灵感来自GSD 2.0和Superpowers方法论

---

**开始使用**：查看 [快速开始指南](docs/getting-started.md) 开始你的第一个项目！