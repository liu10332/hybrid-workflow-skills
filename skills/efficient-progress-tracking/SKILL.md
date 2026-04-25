---
name: efficient-progress-tracking
description: "在 LLM 驱动的工具中实现高效进度追踪 — 通过关键节点触发和 pending_log 机制减少 LLM 调用次数。"
version: 1.0.0
author: OpenClaw Community
license: MIT
metadata:
  tags: [design-pattern, efficiency, state-tracking, llm-optimization]
  related_skills: [hybrid-workflow]
---

# 高效进度追踪模式

## 问题

在 LLM 驱动的工具中，如果每步操作都让 LLM 写进度记录：
- 1小时 ≈ 20-40 次 LLM 调用
- 每次调用消耗 token
- 在限时环境（如 OpenClaw 1小时试用）中代价过高

但记录太少又会导致无法找到精确位置。

## 解决方案：关键节点触发 + pending_log

### 核心机制

```
工具/脚本层（无 LLM 参与）:
  └→ 定时器检测文件变化
     └→ 有变化 → 写 .pending_log 标记
     └→ 无变化 → 跳过

LLM 层（低频参与）:
  └→ 每次响应前检查 .pending_log
     └→ 存在 → 读取摘要，写一条简短 log，删除标记
     └→ 不存在 → 不管
```

### 频率对比

| 方式 | LLM 调用次数/小时 | 定位精度 |
|------|-------------------|----------|
| 每步都记录 | 20-40 次 | 最高 |
| 只记录 checkpoint | 2-3 次 | 最低 |
| **关键节点触发** | **6-12 次** | **适中** |

## 实现要点

### 1. 进度文件格式

```yaml
# position: 简化字段，LLM 随手更新
position:
  project: "项目名"
  task: "当前任务"
  step: "3"
  total_steps: "7"
  note: "自由文本"

# log: 一行文本，时间 + 简短描述
log:
  - "14:05 创建 test_ocr.py"
  - "14:12 测试 fail，准确率72%"
  - "14:20 切换到 paddleocr"

# checkpoints: 只保留已确认的检查点
checkpoints:
  - id: 1
    desc: "OCR框架搭建完成"
    status: "confirmed"
```

### 2. .pending_log 规范

| 属性 | 说明 |
|------|------|
| 位置 | 状态仓库根目录 |
| 写入者 | 定时器脚本 |
| 读取者 | LLM（Agent） |
| 内容 | git diff --stat 摘要 |
| 生命周期 | 写入 → LLM 读取 → 删除 |

### 3. 触发规则

| 事件 | 动作 |
|------|------|
| 文件新建/修改 | 累积，下条 LLM 响应时记录 |
| 测试 pass/fail | 立即记录 |
| 安装新依赖 | 立即记录 |
| 用户输入决策 | 立即记录 |
| 无变化的连续操作 | 不记录 |

### 4. 恢复时处理

```
恢复会话时 → 检查 .pending_log？
  ├─ 存在 → 说明上次会话有未处理变化，读取并写 log
  └─ 不存在 → 正常恢复
```

## 适用场景

- 限时环境（如 OpenClaw 1小时试用）
- 需要跨会话续接的工具
- LLM token 成本敏感的场景
- 任何需要在"记录频率"和"定位精度"之间平衡的场景

## 实现示例

### 脚本层（定时器检测变化）

```bash
# 每15分钟检测变化
git add -A
if ! git diff --cached --quiet; then
    # 有变化，创建 pending_log
    git diff --cached --stat | tail -1 > ".pending_log"
    git commit -m "auto-sync: $(date '+%Y-%m-%d %H:%M')"
    git push origin main
fi
```

### LLM层（Agent 响应时）

```bash
# 检查 pending_log
if [ -f ".pending_log" ]; then
    summary=$(cat ".pending_log")
    # Agent 写一条简短 log
    add_log_entry "$state_dir" "$summary"
    rm ".pending_log"
fi
```

### 恢复时处理

```bash
# 恢复时检查未处理的 pending_log
if [ -f ".pending_log" ]; then
    summary=$(cat ".pending_log")
    add_log_entry "$state_dir" "上次遗留: $summary"
    rm ".pending_log"
fi
```

## 相关模式：VM 级时间限制处理

当环境是 VM 级限时（如1小时后虚拟机销毁），脚本无法检测实际剩余时间。

**解决方案：用户手动输入**

```
会话开始时：
  Agent：⏱️ 当前环境还剩多少分钟？
  用户：55
  Agent：✅ 已设置 55 分钟后到期 → 计算 expires_at = now + 55min

Agent 自检（每次响应时）：
  remaining = (expires_at - now) / 60
  if remaining < 5 → 触发紧急保存 + 提醒用户
  if remaining < 2 → 强烈提醒用户
```

**关键：** 不要用脚本检测时间，而是让用户告诉 Agent 还剩多久。

## 注意事项

1. **不要每步都让 LLM 写** — 用脚本检测变化，LLM 只写简短描述
2. **position 字段要简化** — 6 个字段足够，不要过度结构化
3. **log 格式要简单** — 一行文本，`"HH:MM 描述"`
4. **恢复时检查 pending_log** — 避免丢失上次会话的最后变化
