# Hybrid Workflow Skills - 开源项目

## 项目愿景

将混合工作流（Hybrid Workflow）技能体系开源，为AI Agent驱动的软件开发提供一套完整的项目管理方法论。

## 核心价值

1. **结构化开发**：里程碑→切片→任务三级管理
2. **质量保证**：强制TDD + 两阶段审查
3. **状态驱动**：基于文件的状态管理，支持中断恢复
4. **咀嚼式执行**：每个任务分解为2-5分钟步骤

## 目标用户

- 使用AI Agent进行软件开发的开发者
- 需要结构化项目管理的团队
- 希望提高代码质量的个人开发者

## 技能清单

### 核心编排
1. hybrid-workflow - 主编排技能
2. hybrid-project-init - 项目初始化

### 阶段技能
3. brainstorming - 需求分析
4. discuss-phase - 切片讨论
5. writing-plans - 任务规划
6. subagent-driven-development - 任务执行
7. test-driven-development - TDD执行
8. requesting-code-review - 代码审查

### 支持工具
9. task-workspace - 文件组织
10. efficient-progress-tracking - 进度追踪

## 仓库结构

```
hybrid-workflow-skills/
├── README.md                    # 项目说明
├── LICENSE                      # MIT许可证
├── docs/                        # 文档目录
│   ├── getting-started.md       # 快速开始
│   ├── concepts.md              # 核心概念
│   ├── skills/                  # 每个技能的详细文档
│   └── examples/                # 使用示例
├── skills/                      # 技能文件目录
│   ├── hybrid-workflow/
│   ├── brainstorming/
│   └── ...
├── examples/                    # 示例项目
│   ├── mihomo-quick/            # 已有示例
│   └── simple-web-app/          # 简单示例
├── scripts/                     # 安装和配置脚本
│   ├── install.sh
│   └── setup.sh
└── .github/                     # GitHub配置
    └── workflows/               # CI/CD
```

## 里程碑规划

### M001: 项目骨架（1-2天）
- 创建目录结构
- 编写README.md
- 初始化Git仓库
- 添加LICENSE

### M002: 技能文档（2-3天）
- 为每个技能编写详细文档
- 创建快速开始指南
- 编写核心概念文档

### M003: 示例项目（2-3天）
- 创建简单示例项目
- 编写示例文档
- 演示完整工作流

### M004: 工具脚本（1-2天）
- 安装脚本
- 配置生成器
- 验证脚本

### M005: 发布准备（1天）
- 最终测试
- 文档审查
- GitHub发布