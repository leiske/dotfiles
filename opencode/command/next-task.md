---
description: Complete the next incomplete task from a plan document
---

Complete one task from a plan file. Implements the next task with unresolved tasks, runs feedback loops, and commits.

## Usage

```
/next-task <plan document>
```

Where `<plan document>` matches a file in the root of the repository matching the name.
If no `<plan document>` is provided, defaults to `plan.md`.

## Process

### 1. Get Bearings

- Read task-memory.md file - **CHECK 'Codebase Patterns' SECTION FIRST**
- Read plan document - find next task with unresolved tasks
  - **Task Priority** (highest to lowest):
    1. Architecture/core abstractions
    2. Integration points
    3. Spikes/unknowns
    4. Standard features
    5. Polish/cleanup
- Check recent history (git: `git log --oneline -10`)

### 2. Initialize task memory (if needed)

If task-memory.md doesn't exist, create it:

```markdown
# task memory Log
plan: <plan document>
Started: <YYYY-MM-DD>

## Codebase Patterns
<!-- Consolidate reusable patterns here -->

---
<!-- Task logs below - APPEND ONLY -->
```

### 4. Implement Task

Work on the single task until verification steps pass. Do not make drive-by unrelated changes. Stay on track for the given task. Unless you have a blocking question, keep going until completed.


### 5. Feedback Loops (REQUIRED)

Before committing, run ALL applicable:
- Tests
- Linting
- Formatting

**Do NOT commit if any fail.** Fix issues first.

### 6. Update PRD

Fill in the checkbox for the task you've completed after validating it works as expected

### 7. Update task memory

Append to task-memory.md:

```markdown
## Task - [task.id]
- What was implemented
- Files changed
- **Learnings:** patterns, gotchas
```

If you discover a **reusable pattern**, also add to `## Codebase Patterns` at the TOP.

### 8. Commit

- git: `git add -A && git commit -m 'feat(<scope>): <description>'`

Bookmark format: `<planName>/<task-id>` (e.g., `lib-relay-implementation/types-2`)

## Completion

If all tasks have been marked as done in the <plan document>, output:

```
<tasks>COMPLETE</tasks>
```

## Philosophy

This codebase will outlive you. Every shortcut becomes someone else's burden. Patterns you establish will be copied. Corners you cut will be cut again.

Fight entropy. Leave the codebase better than you found it.

<user-request>
$ARGUMENTS
</user-request>
