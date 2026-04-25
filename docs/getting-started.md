# 快速开始指南

本指南帮助你快速上手Hybrid Workflow Skills，开始你的第一个结构化项目。

## 前置条件

- Git已安装
- 基本的命令行知识
- 文本编辑器（推荐VS Code）

## 安装

### 方式1：克隆仓库

```bash
# 克隆仓库
git clone https://github.com/your-username/hybrid-workflow-skills.git

# 进入目录
cd hybrid-workflow-skills

# 运行安装脚本
./scripts/install.sh
```

### 方式2：手动安装

```bash
# 创建技能目录
mkdir -p ~/.hermes/skills/

# 复制技能文件
cp -r skills/* ~/.hermes/skills/
```

## 验证安装

运行验证脚本检查安装是否成功：

```bash
./scripts/validate.sh
```

如果看到"所有检查通过！"，说明安装成功。

## 第一个项目

### 步骤1：初始化项目

使用`hybrid-project-init`技能初始化新项目：

```bash
# 创建项目目录
mkdir my-first-project
cd my-first-project

# 初始化混合工作流结构
mkdir -p .hybrid/milestones/M001/slices/S01/tasks
```

### 步骤2：创建项目文件

创建基本项目文件：

```bash
# 创建PROJECT.md
cat > .hybrid/PROJECT.md << 'EOF'
# 我的第一个项目

## 项目愿景
学习混合工作流方法论。

## 目标
完成一个简单的待办事项应用。
EOF

# 创建STATE.md
cat > .hybrid/STATE.md << 'EOF'
# 项目状态

## 当前位置
- 里程碑：M001
- 切片：S01
- 任务：T01
- 阶段：planning

## 进度
- 里程碑进度：0%
- 切片进度：0%
- 任务进度：0%
EOF
```

### 步骤3：规划第一个切片

创建切片计划：

```bash
# 创建切片计划
cat > .hybrid/milestones/M001/slices/S01/S01-PLAN.md << 'EOF'
# S01: 项目初始化

## 目标
创建项目基础结构

## 任务
- T01: 创建目录结构
- T02: 创建README.md
- T03: 初始化Git仓库

## 验收标准
- [ ] 目录结构完整
- [ ] README.md存在
- [ ] Git仓库初始化
EOF
```

### 步骤4：执行任务

按照计划执行任务：

```bash
# 任务T01：创建目录结构
mkdir -p src tests docs

# 任务T02：创建README.md
cat > README.md << 'EOF'
# 我的第一个项目

这是一个使用混合工作流开发的项目。

## 功能
- 功能1
- 功能2
- 功能3

## 使用方法
...
EOF

# 任务T03：初始化Git仓库
git init
git add .
git commit -m "Initial commit"
```

### 步骤5：更新状态

完成任务后更新状态：

```bash
# 更新STATE.md
cat > .hybrid/STATE.md << 'EOF'
# 项目状态

## 当前位置
- 里程碑：M001
- 切片：S01
- 任务：T03
- 阶段：completed

## 进度
- 里程碑进度：100%
- 切片进度：100%
- 任务进度：100%

## 已完成工作
- [x] 创建目录结构
- [x] 创建README.md
- [x] 初始化Git仓库
EOF
```

## 工作流程示例

### 需求分析阶段

```bash
# 使用brainstorming技能
# 1. 探索项目上下文
# 2. 提出澄清问题
# 3. 提出方案
# 4. 编写设计文档
```

### 设计讨论阶段

```bash
# 使用discuss-phase技能
# 1. 分析切片范围
# 2. 讨论灰色区域
# 3. 记录决策
# 4. 生成上下文文件
```

### 任务规划阶段

```bash
# 使用writing-plans技能
# 1. 阅读切片上下文
# 2. 分解任务
# 3. 创建详细计划
# 4. 分析依赖关系
```

### 任务执行阶段

```bash
# 使用subagent-driven-development技能
# 1. 分解为咀嚼式步骤
# 2. 执行红绿重构循环
# 3. 进行两阶段审查
# 4. 更新任务状态
```

## 示例项目

查看`examples/simple-web-app/`目录，了解完整的项目示例：

```bash
# 进入示例项目
cd examples/simple-web-app

# 运行示例
./run.sh

# 访问 http://localhost:8000
```

## 常见问题

### Q: 如何恢复中断的工作？

A: 读取`.hybrid/STATE.md`文件，了解当前状态，从最近的检查点继续。

### Q: 如何查看项目进度？

A: 查看`.hybrid/STATE.md`文件，或者运行`./scripts/validate.sh`检查项目完整性。

### Q: 如何添加新技能？

A: 在`skills/`目录下创建新目录，添加`SKILL.md`文件，参考现有技能格式。

### Q: 如何贡献代码？

A: 查看`CONTRIBUTING.md`文件，了解贡献流程。

## 下一步

1. **阅读核心概念**：查看`docs/concepts.md`了解混合工作流的核心概念
2. **查看技能文档**：浏览`docs/skills/`目录了解每个技能的详细用法
3. **尝试示例项目**：运行`examples/simple-web-app/`体验完整流程
4. **开始你的项目**：使用混合工作流开始你的第一个项目

## 获取帮助

- 查看文档：`docs/`目录
- 提交Issue：GitHub Issues
- 参与讨论：GitHub Discussions

## 相关资源

- [核心概念](docs/concepts.md)
- [技能文档](docs/skills/)
- [使用示例](docs/examples/)
- [贡献指南](CONTRIBUTING.md)

---

**开始你的第一个项目**：按照上述步骤，创建你的第一个混合工作流项目！