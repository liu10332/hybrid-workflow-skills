---
name: hybrid-project-init
description: "Initialize a new project using hybrid-workflow methodology - from brainstorming through design to first slice execution."
version: 1.0.0
author: OpenClaw Community
license: MIT
metadata:
  tags: [workflow, project-management, planning, initialization]
  related_skills: [hybrid-workflow, brainstorming, writing-plans, discuss-phase]
---

# Hybrid Project Init

Practical guide for initializing projects using hybrid-workflow methodology. Demonstrates the complete flow from requirements gathering through design to first working slice.

## When to Use

- Starting a new software project from scratch
- User wants structured project management
- Project will be shared (GitHub) or has multiple milestones
- Requirements need proper elicitation (not immediately clear)

## Critical Lesson: Don't Jump to Implementation

**Anti-pattern**: User describes a need → immediately start building scripts
**Correct approach**: User describes a need → brainstorm requirements → design → plan → execute

The user's "simple" request often has hidden complexity that only emerges through proper requirements gathering.

## Initialization Flow

### Phase 1: Brainstorming (REQUIRED FIRST)

Before writing ANY code, use brainstorming skill to:
1. Explore project context (what exists already?)
2. Ask clarifying questions ONE AT A TIME
3. Propose 2-3 approaches with trade-offs
4. Get user approval on design direction
5. Write design document to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`

**Key questions to ask:**
- What's the target audience? (personal/team/open-source)
- What's "lightweight" mean to them? (files/dependencies/resources)
- What features are MUST vs NICE-TO-HAVE?
- What's the distribution method? (local/GitHub/package)

### Phase 2: Create .hybrid Structure

After design approval, create project management structure:

```
.hybrid/
├── PROJECT.md          # Vision and goals
├── REQUIREMENTS.md     # Functional/non-functional requirements
├── ROADMAP.md          # Milestone timeline
├── STATE.md            # Current position (SINGLE SOURCE OF TRUTH)
└── milestones/
    └── M001/
        ├── M001-ROADMAP.md
        ├── M001-CONTEXT.md
        └── slices/
            └── S01/
                ├── S01-PLAN.md
                └── tasks/
                    ├── T01-PLAN.md
                    └── T01-SUMMARY.md
```

### Phase 3: Plan First Milestone

Break down into slices and tasks:
- Each slice: 1-3 days of work
- Each task: 2-5 minutes (chewable steps)
- Create PLAN.md for each slice and task
- No placeholders or TBDs

### Phase 4: Execute First Tasks

Follow TDD where applicable:
1. Read task plan
2. Execute steps
3. Create task summary
4. Update STATE.md
5. Git commit
6. Repeat

## STATE.md Discipline

STATE.md MUST be updated:
- After each slice completion
- After milestone transitions
- When blocking issues discovered
- Before ending any session

**Never** rely only on PROGRESS.md or LOG.md - STATE.md is the authoritative source.

## Example: mihomo-quick Project

This skill was derived from the mihomo-quick project initialization:

**Requirements gathered:**
- Multi-mode support (TUN/System/TAP/Mixed)
- Subscription management with fault tolerance
- Interactive config generation
- Web dashboard integration
- Blacklist/whitelist rules
- GitHub-ready for sharing

**Milestones planned:**
- M001: Base architecture (1-2 days)
- M002: Config management (2-3 days)
- M003: Subscription management (3-4 days)
- M004: Service management (2-3 days)
- M005: Web panel and release (2-3 days)

**First slice completed:**
- T01: Directory structure
- T02: README.md documentation
- T03: Git initialization
- T04: Config templates (9 files)

## Checklist for New Project

- [ ] Brainstorming complete with user approval
- [ ] Design document written and reviewed
- [ ] .hybrid directory created
- [ ] PROJECT.md, REQUIREMENTS.md, ROADMAP.md, STATE.md created
- [ ] First milestone planned with slices
- [ ] First slice planned with tasks
- [ ] First task ready to execute
- [ ] Git repository initialized

## Common Mistakes

1. **Skipping brainstorming** - "It's simple enough" is always wrong
2. **Vague requirements** - Get specifics before designing
3. **Oversized tasks** - Tasks should be 2-5 minutes each
4. **Not updating STATE.md** - Breaks recovery mechanism
5. **No task summaries** - Loses institutional knowledge

## Related Skills

- `hybrid-workflow` - Main orchestration methodology
- `brainstorming` - Requirements elicitation
- `writing-plans` - Plan creation
- `discuss-phase` - User preference gathering
- `test-driven-development` - Implementation approach
