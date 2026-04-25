---
name: task-workspace
description: "Auto-organize generated files into versioned project directories under ~/workspace/. Supports sub-tasks, version tracking, and intelligent project detection."
version: 2.0.0
author: OpenClaw Community
license: MIT
metadata:
  tags: [productivity, workspace, files, organization, versioning]
---

# Task Workspace

Automatically organize files into versioned project directories with sub-task support.

## Directory Structure

```
~/workspace/
├── .index.json                        # 全局项目索引（自动生成）
├── 项目A/
│   ├── META.md                        # 项目元数据
│   ├── README.md                      # 项目说明（自动生成）
│   ├── current -> v2                  # 软链接 → 当前版本
│   ├── v1/
│   │   └── .version.md                # 版本备注
│   ├── v2/
│   │   ├── .version.md
│   │   ├── 子任务1/
│   │   └── 子任务2/
│   └── archive/                       # 归档旧版本
│       └── v0-20260315/
└── 项目B/
    └── ...
```

## When to Trigger

- "帮我写一个..." / "帮我创建..."
- "生成一个..."
- "做一个..."
- "再改改..." / "再帮我..."（重复任务 = 新版本）

## Workflow

### Step 1: Determine Project Context (混合方案)

按优先级判断归属：

**1) 用户显式指定路径 → 直接用**
- "在数据分析项目下写个清洗脚本" → 归入 `数据分析项目/`
- "放到 ~/workspace/web项目/ 里" → 归入 `web项目/`

**2) 对话上下文有明确项目引用 → 归入该项目**
- 刚创建/讨论过某个项目，用户紧接着说"写个XX" → 归入
- 识别词："这个项目"、"接着做"、"顺便"、"在这个基础上"

**3) 关键词匹配已有项目且高度相关 → 归入，但告知用户**
- 用户说"写个可视化脚本"，已有 `数据分析项目/`
- 告知："我把它归入 数据分析项目/，对吗？"

**4) 都不满足 → 创建独立新任务**
- 用户说"帮我写个爬虫"，和现有项目无关 → 新建 `爬虫/`

### Step 2: Resolve Target Directory

```bash
# 列出现有项目
ls -1d ~/workspace/*/ 2>/dev/null
```

**新建项目：**
```bash
mkdir -p ~/workspace/{项目名}/v1
```

**新版本（已有项目）：**
```bash
# 找到最大版本号，+1
ls -d ~/workspace/{项目名}/v* 2>/dev/null | sort -V | tail -1
mkdir -p ~/workspace/{项目名}/v{N+1}
```

**子任务（项目内）：**
```bash
# 直接在 current 版本下建子目录
mkdir -p ~/workspace/{项目名}/current/{子任务名}/
```

### Step 3: Create META.md (新项目时)

```markdown
# {项目名}

创建时间: {YYYY-MM-DD}
描述: {从用户需求中提取的一句话描述}
标签: {自动推断的标签}
版本历史:
- v1: 初始版本
```

### Step 4: Write Files

将文件写入目标目录。

每个版本目录内创建 `.version.md`：
```markdown
版本: v{N}
日期: {YYYY-MM-DD}
内容: {这次写了什么的简短描述}
```

### Step 5: Update `current` Symlink

```bash
cd ~/workspace/{项目名} && ln -sfn v{N} current
```

### Step 6: Update `.index.json`

更新后写入：
```json
{
  "projects": {
    "数据分析项目": {
      "current_version": 2,
      "last_updated": "2026-04-10",
      "description": "销售数据清洗和可视化分析",
      "tags": ["python", "数据分析"]
    }
  }
}
```

### Step 7: Report to User

```
Files saved to ~/workspace/数据分析项目/current/
  ├─ clean.py (数据清洗)
  └─ charts.py (可视化图表)
当前版本: v2
```

## Rules

1. **版本内聚** — 同一任务的所有版本在同一个项目目录下，用 `v1/`、`v2/` 区分
2. **子任务分层** — 项目内的子任务用子目录组织，不扁平堆放
3. **current 始终指向最新** — 写入后立即更新软链接
4. **所有文件入目录** — 不在 `~/workspace/` 根目录放散文件
5. **记录变更** — 每个版本写 `.version.md`，记录改了什么
6. **归档而非删除** — 清理时移入 `archive/`，不直接删

## Archive Old Versions

当用户说"清理旧版本"或版本过多时：

```bash
mkdir -p ~/workspace/{项目名}/archive
mv ~/workspace/{项目名}/v1 ~/workspace/{项目名}/archive/v1-$(date +%Y%m%d)
```

## List Projects

当用户问"有哪些项目"或"看下 workspace"：

```bash
# 方式1：读索引
cat ~/workspace/.index.json 2>/dev/null

# 方式2：列目录
ls -1d ~/workspace/*/ 2>/dev/null
```
