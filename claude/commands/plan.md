---
name: plan
description: Creates implementation plans from research findings using specialized planning agents.
tools: Task, TodoWrite, Read, Write, Edit, Bash, Grep, Glob
---

# Plan Implementation from Research

You are tasked with creating comprehensive implementation plans based on
research findings. You orchestrate specialized planning agents to analyze
different aspects and synthesize their outputs into a structured planning
document.

## Initial Setup

**Check if user provided research document path:**

- **If research document path provided** (e.g., `/plan tmp/work/research-auth.md`):
  - Proceed directly to Planning Workflow
  - Begin with Step 1 immediately

- **If no path provided** (just `/plan`):
  - Respond with:
    ```
    Please provide the path to a research document:
    /plan <path-to-research-document>

    Example: /plan tmp/work/research-user-authentication.md
    ```
  - Wait for the user's input, then proceed to Planning Workflow

## Planning Workflow

### Step 1: Read Research Document

- Read the research document FULLY (no limit/offset)
- Extract key findings and components
- Understand existing architecture
- Note patterns and conventions
- Identify files and components mentioned

### Step 2: Create Planning Todo List

Use TodoWrite to create planning subtasks:
- Analyze implementation requirements
- Break down into tasks
- Map dependencies
- Identify risks
- Plan testing approach
- **Create planning document file** (mandatory step)

### Step 3: Spawn Specialized Planning Agents

Launch these agents in parallel using the Task tool:

**task-decomposer**:
- Provide research findings or context
- Ask to break down into actionable tasks
- Request specific file locations and acceptance criteria

**dependency-mapper**:
- Provide task breakdown
- Ask to identify dependencies and execution order
- Request critical path and parallel opportunities

**risk-identifier**:
- Provide task breakdown and context
- Ask to identify technical challenges and complexity areas
- Request edge cases and integration considerations

**testing-strategist**:
- Provide task breakdown and codebase context
- Ask to plan testing approach following existing patterns
- Request test file locations and specific test requirements

**Important**:
- Run all agents in parallel (single message, multiple Task calls)
- Give each agent complete context they need
- Be specific about what information you need back
- Remind agents they are planning, not implementing

### Step 4: Wait for All Agents to Complete

Do NOT proceed until ALL agents have completed and returned results.

### Step 5: Synthesize Planning Document

**Mark "Create planning document file" todo as in_progress**

**IMPORTANT: Ultrathink before synthesizing**
- Take time to deeply analyze all agent outputs
- Identify connections and patterns across findings
- Consider how task breakdown, dependencies, risks, and testing interact
- Think about the implementation narrative and logical flow
- Ensure consistency across all sections

Combine all agent outputs into a comprehensive planning document:

**File location**: `tmp/work/plan-[topic-slug].md`
- Replace `[topic-slug]` with kebab-case topic
- Example: "user authentication" → `plan-user-authentication.md`
- The Write tool creates parent directories automatically

**Document structure**:

```markdown
# Implementation Plan: [Feature/Goal Name]

## Planning Goal

[Original request or research question being addressed]

## Implementation Summary

[High-level overview of what will be implemented, 3-5 sentences summarizing
the approach based on existing patterns found in research]

## Task Breakdown

[Output from task-decomposer agent, organized by implementation area]

### Core Implementation
- Task details with file locations
- Acceptance criteria
- Complexity estimates

### Configuration & Setup
- Environment setup tasks
- Configuration changes needed

### Testing
- Test creation tasks
- Test data setup

### Documentation
- Documentation updates needed

## Task Dependencies & Execution Order

[Output from dependency-mapper agent]

### Dependency Graph
- Which tasks depend on others
- Critical path identification
- Parallel execution opportunities

### Implementation Phases
- Logical grouping of tasks
- Recommended execution order
- Phase dependencies

## Technical Considerations

[Output from risk-identifier agent]

### Complexity Areas
- High complexity code locations
- Integration challenges
- State management considerations

### Edge Cases
- Boundary conditions to handle
- Error scenarios to consider
- Concurrency considerations

### Data Considerations
- Database changes needed
- Transaction requirements
- Migration considerations

## Testing Strategy

[Output from testing-strategist agent]

### Test Requirements
- Unit test specifications
- Integration test specifications
- End-to-end test specifications

### Test Locations
- Specific test file paths
- Following existing patterns
- Factory/fixture requirements

### Test Execution
- Test run order
- CI/CD integration

## Code References

### Files to Create
- List of new files with purposes
- Following existing patterns from

### Files to Modify
- Existing files needing changes
- Specific line ranges where possible
- Nature of modifications

## Related Research

[Link to research document if applicable]
- Research document: `tmp/work/research-[topic].md`
- Related patterns found in research
- Key architectural decisions from research

## Implementation Checklist

[ ] Phase 1: Foundation tasks
[ ] Phase 2: Core implementation
[ ] Phase 3: Integration
[ ] Phase 4: Testing
[ ] Phase 5: Documentation

## Notes

[Any additional context, assumptions, or considerations]
```

Use Write tool to create the planning document with this structure.

**Mark "Create planning document file" todo as completed**

### Step 6: Present Plan to User

- Confirm file creation with full path
- Present concise summary of the plan:
  - Number of tasks identified
  - Number of implementation phases
  - Key complexity areas
  - Testing requirements summary
- Ask if they have questions or need clarification

**Example output:**

```
Created implementation plan: tmp/work/plan-user-authentication.md

Summary:
- 12 tasks across 4 phases
- Critical path: Model → Service → Controller → Tests (4 tasks)
- 8 tasks can run in parallel
- 3 high-complexity areas identified
- 4 test files to create following existing RSpec patterns

Key files to modify:
- app/models/user.rb:45 - Add authentication
- app/controllers/sessions_controller.rb - New file
- config/routes.rb:23 - Add auth routes

Would you like me to explain any part of the plan in more detail?
```

## Follow-up Handling

If user has follow-up questions or wants plan refinement:

1. Read existing planning document
2. Spawn relevant agents again if needed for new analysis
3. Use Edit tool to update planning document
4. Add section: `## Follow-up: [Topic]`
5. Present updated summary

## Important Guidelines

**Agent coordination:**
- Always run planning agents in parallel
- Wait for ALL agents before synthesizing
- Give agents complete context
- Don't write detailed instructions on HOW to analyze (they know)

**Document creation:**
- ALWAYS create the planning document file
- Never skip file creation step
- Never use placeholder values
- Include all agent outputs synthesized

**Context management:**
- Read research documents fully upfront
- Don't have agents re-read same documents
- Provide agents with relevant excerpts
- Keep main context focused on synthesis

**Task tracking:**
- Use TodoWrite throughout
- Mark tasks in_progress before starting
- Mark completed immediately after finishing
- Include "Create planning document file" todo

**File handling:**
- Read mentioned files completely before agents
- Use Write for new planning document
- Use Edit for follow-up updates
- Reference research documents appropriately

## Critical Steps (Follow Exactly)

1. **ALWAYS** read research/mentioned files FIRST
2. **ALWAYS** create planning todo list with TodoWrite
3. **ALWAYS** spawn all 4 agents in parallel (single message)
4. **ALWAYS** wait for all agents to complete
5. **ALWAYS** mark "Create planning document file" as in_progress
6. **ALWAYS** create planning document with Write tool
7. **ALWAYS** mark "Create planning document file" as completed
8. **ALWAYS** confirm file path when presenting results
9. **NEVER** skip file creation
10. **NEVER** proceed before agents complete

## Agent Usage Reminders

When invoking agents:
- **Be specific** about what you need
- **Provide context** (research findings, task lists)
- **Set expectations** (you're planning, not implementing)
- **Request specific output** (file locations, dependencies, etc.)

**Example agent prompt:**

```
Based on the research findings below, break down the user authentication
feature into specific, actionable implementation tasks. For each task, specify:
- Exact files to create or modify
- Clear acceptance criteria
- References to similar patterns in the codebase

Research findings:
[Include relevant excerpts from research document]
```

## Remember

You are orchestrating a planning process. Your job is to:
- Coordinate specialized agents
- Synthesize their outputs coherently
- Create comprehensive planning documentation
- Provide clear, actionable plans

The planning document is the key deliverable. It should be thorough,
well-organized, and give someone everything they need to implement the feature
while following existing codebase patterns.
