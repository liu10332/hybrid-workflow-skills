---
name: hybrid-workflow
description: "混合工作流主编排技能 - 协调切片级任务管理和咀嚼式任务执行。适用于中大型软件开发项目。"
version: 1.0.0
author: OpenClaw Community
license: MIT
metadata:
  tags: [workflow, orchestration, planning, execution, project-management]
  related_skills: [brainstorming, discuss-phase, writing-plans, subagent-driven-development, test-driven-development, requesting-code-review]
---

# Hybrid Workflow 混合工作流技能

协调切片级任务管理和咀嚼式任务执行的主编排技能。结合GSD 2.0的宏观管理和Superpowers的微观执行。

## 核心理念

1. **宏观组织**：按里程碑→切片→任务三级结构管理项目
2. **微观执行**：每个任务分解为2-5分钟的咀嚼式步骤，强制TDD
3. **状态驱动**：基于文件的`.hybrid/`状态管理，支持中断恢复
4. **质量保证**：两阶段审查（规格符合性+代码质量）

## 文件结构

```
.hybrid/
├── PROJECT.md                 # 项目愿景
├── REQUIREMENTS.md            # 需求规格
├── ROADMAP.md                 # 路线图
├── STATE.md                   # 当前状态（派生缓存）
├── DECISIONS.md               # 决策记录（仅附加）
├── CODEBASE.md                # 代码库映射缓存（自动生成）
├── milestones/
│   ├── M001/
│   │   ├── M001-ROADMAP.md    # 里程碑计划
│   │   ├── M001-CONTEXT.md    # 用户决策
│   │   ├── M001-RESEARCH.md   # 技术研究
│   │   ├── M001-SUMMARY.md    # 里程碑总结
│   │   └── slices/
│   │       ├── S01/
│   │       │   ├── S01-PLAN.md        # 切片计划
│   │       │   ├── S01-CONTEXT.md     # 切片决策
│   │       │   ├── S01-RESEARCH.md    # 切片研究
│   │       │   ├── S01-SUMMARY.md     # 切片总结
│   │       │   ├── S01-UAT.md         # 验收测试
│   │       │   ├── continue.md        # 恢复点（临时）
│   │       │   └── tasks/
│   │       │       ├── T01-PLAN.md    # 任务计划
│   │       │       ├── T01-SUMMARY.md # 任务总结
│   │       │       └── ...
│   │       └── S02/
│   │           └── ...
│   └── M002/
│       └── ...
└── skills/                    # 项目特定技能（可选）
    └── ...
```

## 工作流阶段

### 阶段1：项目初始化
**命令**：`/hybrid init [项目描述]`
**技能**：`brainstorming`
**输出**：PROJECT.md, REQUIREMENTS.md, ROADMAP.md

**流程**：
1. 调用brainstorming技能进行需求分析
2. 生成项目愿景和需求规格
3. 创建里程碑路线图
4. 初始化状态文件

### 阶段2：里程碑讨论
**命令**：`/hybrid discuss-milestone [里程碑ID]`
**技能**：`discuss-phase`
**输出**：M{ID}-CONTEXT.md

**流程**：
1. 分析里程碑范围
2. 识别关键决策点
3. 逐一讨论灰色区域
4. 记录用户决策

### 阶段3：切片规划
**命令**：`/hybrid plan-slice [切片ID]`
**技能**：`writing-plans`
**输出**：S{ID}-PLAN.md, tasks/T{ID}-PLAN.md

**流程**：
1. 阅读切片上下文和需求
2. 将切片分解为任务
3. 为每个任务创建详细计划
4. 分析任务依赖关系

### 阶段4：任务执行
**命令**：`/hybrid execute-task [任务ID]`
**技能**：`subagent-driven-development`, `test-driven-development`
**输出**：实现代码, 测试, 提交, T{ID}-SUMMARY.md

**流程**：
1. 将任务计划分解为咀嚼式步骤
2. 执行红绿重构循环
3. 进行两阶段审查
4. 更新任务状态

### 阶段5：切片验证
**命令**：`/hybrid verify-slice [切片ID]`
**技能**：`requesting-code-review`, `slice-verification`
**输出**：S{ID}-SUMMARY.md, S{ID}-UAT.md

**流程**：
1. 运行切片级测试
2. 验证功能完整性
3. 生成用户验收测试
4. 更新切片状态

### 阶段6：里程碑交付
**命令**：`/hybrid deliver-milestone [里程碑ID]`
**技能**：`milestone-completion`
**输出**：M{ID}-SUMMARY.md, 发布说明

**流程**：
1. 验证里程碑成功标准
2. 生成发布说明
3. 打包交付物
4. 准备下一个里程碑

## 状态机

状态存储在`.hybrid/STATE.md`中：

```yaml
# 项目状态
project: "矿井水文监测系统"
version: "1.0.0"
created: 2026-04-18

# 当前位置
milestone: M001
slice: S01
task: T02
phase: executing  # initializing, discussing, planning, executing, verifying, delivering

# 进度跟踪
progress:
  milestone: 35%
  slice: 60%
  task: 80%

# 最后活动
last_activity: 2026-04-18T10:30:00Z
last_action: "执行任务T02步骤3"

# 性能指标
velocity:
  tasks_per_day: 8.5
  average_task_duration: 25min
  success_rate: 92%

# 检查点
checkpoints:
  - timestamp: 2026-04-18T09:00:00Z
    phase: planning
    description: "完成切片S01规划"
  - timestamp: 2026-04-18T10:30:00Z
    phase: executing
    description: "开始任务T02执行"
```

## 恢复机制

### STATE.md 更新纪律（重要！）

**STATE.md 必须是项目进度的唯一权威来源。** 详细进度记录（PROGRESS.md、LOG.md）是补充材料，但 STATE.md 必须始终反映最新状态。

**必须更新 STATE.md 的时机**（每次都要，不能攒到最后）：
1. **切片完成时** — 更新"当前位置"和"项目历程"
2. **里程碑切换时** — 更新里程碑、切片编号和阶段
3. **阶段性测试通过/失败时** — 更新进度百分比和待测项
4. **发现新问题或阻塞时** — 更新"待完成工作"和问题清单
5. **会话结束前** — 最后一次同步 STATE.md，确保下次能接上
6. **每完成3-5个任务后** — 中途检查点更新，不要等到切片结束

**更新 STATE.md 时至少改这几项**：
- `当前位置` → milestone、slice、进度百分比
- `项目历程` → 追加本次会话的关键进展
- `下一步` → 更新为当前真实待办
- `已完成工作` → 追加本次完成的内容

**反模式（不要这样做）**：
- ❌ 只更新 PROGRESS.md 不更新 STATE.md
- ❌ 攒到里程碑结束才更新 STATE.md
- ❌ "反正下个会话会读 PROGRESS.md，STATE.md 晚点再说"

### 检查点系统
每个阶段完成后自动创建检查点：
1. **项目初始化检查点**：创建项目文件后
2. **里程碑讨论检查点**：记录用户决策后
3. **切片规划检查点**：生成任务计划后
4. **任务执行检查点**：每个关键步骤后
5. **切片验证检查点**：生成验收测试后

### 恢复协议
1. 读取`.hybrid/STATE.md`确定当前状态
2. 查找最近的检查点文件
3. 从检查点恢复执行
4. 更新状态文件

**注意**：如果 STATE.md 读出来发现明显过时（比如停留在很久以前的里程碑），再扫描 `*PROGRESS.md`、`*LOG.md`、`memory/工作日志` 交叉验证。正常情况下 STATE.md 应该是最新的。

### 快速恢复协议（当用户问项目进展时）
**触发条件**：用户询问项目进展、状态、或"进行到哪里了"
**必须执行**：
1. 读取 `.hybrid/STATE.md`（应为最新状态）
2. 检查 `milestones/` 目录结构确认
3. 汇报当前里程碑、切片、任务状态
4. 如有需要，读取最近的检查点文件

## 质量保证

### 硬性门槛
1. **设计批准门槛**：未完成设计讨论不得开始规划
2. **TDD门槛**：没有失败测试不得编写生产代码
3. **审查门槛**：未通过两阶段审查不得标记任务完成
4. **上下文门槛**：未完成切片讨论不得开始切片规划

### 自动化检查
- 任务计划完整性检查（无占位符）
- 测试覆盖率检查
- 代码质量静态分析
- 安全漏洞扫描

## 与其他技能集成

### 必需技能
1. **brainstorming**：需求分析
2. **discuss-phase**：切片讨论
3. **writing-plans**：任务规划
4. **subagent-driven-development**：任务执行
5. **test-driven-development**：TDD执行
6. **requesting-code-review**：代码审查

### 可选技能
1. **systematic-debugging**：问题调试
2. **verification-before-completion**：完成前验证
3. **finishing-a-development-branch**：分支完成

### 工具集成
1. **rag-tool**：检索项目文档和知识库
2. **rag-writer**：生成项目文档
3. **task-workspace**：组织生成文件

## 使用示例

### 示例1：启动新项目
```
用户：我需要开发矿井水文监测系统
Agent：我将使用混合工作流来帮助你。首先，让我启动项目初始化阶段。
[调用brainstorming技能]
[探索项目上下文]
[询问关键问题]
[提出架构方案]
[生成项目文件]
项目初始化完成。现在我们可以开始第一个里程碑的讨论。
```

### 示例2：执行任务
```
用户：开始执行S01的T02任务
Agent：我将执行任务T02：实现Modbus协议解析。
首先，让我读取任务计划...
任务计划包含6个步骤。我将按咀嚼式步骤执行：

步骤1：编写失败测试
[创建测试文件]
[运行测试验证失败]
测试按预期失败。步骤1完成。

步骤2：编写最小实现
[创建实现文件]
[运行测试验证通过]
测试通过。步骤2完成。

[继续执行剩余步骤]
[进行两阶段审查]
任务T02完成。更新状态文件。
```

### 示例3：恢复中断的工作
```
用户：继续之前的工作
Agent：让我检查当前状态...
[读取STATE.md]
[发现最后状态：任务T02步骤3]
[查找检查点]
[恢复执行]
从任务T02步骤3继续执行...
```

## 命令参考

### 项目管理
- `/hybrid init [描述]` - 初始化新项目
- `/hybrid status` - 显示当前状态
- `/hybrid resume` - 恢复中断的工作

### 里程碑管理
- `/hybrid discuss-milestone [ID]` - 讨论里程碑
- `/hybrid deliver-milestone [ID]` - 交付里程碑

### 切片管理
- `/hybrid plan-slice [ID]` - 规划切片
- `/hybrid verify-slice [ID]` - 验证切片

### 任务管理
- `/hybrid execute-task [ID]` - 执行任务
- `/hybrid review-task [ID]` - 审查任务

### 报告生成
- `/hybrid report-progress` - 进度报告
- `/hybrid report-velocity` - 速度报告
- `/hybrid report-quality` - 质量报告

## 注意事项

1. **复杂度控制**：对于简单任务，可以跳过某些阶段
2. **灵活调整**：根据项目需求调整工作流
3. **持续改进**：根据使用反馈优化流程
4. **文档维护**：保持工作流文档更新

## 扩展点

1. **自定义阶段**：添加项目特定阶段
2. **质量门控**：自定义质量检查规则
3. **集成插件**：集成第三方工具和服务
4. **报告模板**：自定义报告格式和内容
