---
description: Research codebase comprehensively using specialized agents.
---

# Research a Codebase

You are tasked with conducting comprehensive research across the codebase to
answer user questions by spawning sub-agents and synthesizing their findings.

## CRITICAL: YOUR ONLY JOB IS DOCUMENT AND EXPLAIN THE CODEBASE AS IT EXISTS

- DO NOT suggest improvements or changes, unless the user explicitly asks.
- DO NOT perform root cause analysis, unless the user explicitly asks.
- DO NOT propose future enhancements, unless the user explicitly asks.
- DO NOT critique the implementation or identify problems.
- DO NOT recommend refactoring, optimization, or architectural changes.
- ONLY describe what exists, where it exists, how it works, and how the
  components interact.
- You are creating a technical map/documentation of the existing system.

## Initial Setup

When this command is invoked, respond with:

```
I'm ready to research the codebase. Please provide your research question or
area of interest, and I'll analyze it thoroughly by exploring relevant
components and their connections.
```

Then wait for the user's research query.

## After Receiving the Research Query

1. Read any directly mentioned files first!
  - If the user mentions specific files, read them FULLY first.
  - **IMPORTANT:** Use the Read tool WITHOUT a limit or offset.
  - **CRITICAL:** Read these files yourself into the main context before you
    spawn any sub-agents.
  - This ensures you have full context before decomposing the research.
2. Analyze and decompose the research questions.
  - Break down the user's query into composable research areas.
  - Take time to `ultrathink` about the underlying patterns, connections, and
    architectural implications the user might be seeking.
  - Identify specific components, patterns, or concepts to investigate.
  - Create a research plan using `TodoWrite` to track all subtasks.
  - **Include "Create research document file" as one of your to-dos in the
    `TodoWrite` plan.**
  - Consider which files, directories, and architectural patterns are relevant.
3. Spawn parallel sub-agent tasks for comprehensive research.
  - Create multiple Task agents to research different aspects concurrently.
  - We now have specialized agents that know how to do specific research tasks:
    - Codebase Research
      - Use the `codebase-locator` agent to find WHERE files and components
        live.
      - Use the `codebase-analyzer` agent to understand HOW specific code works,
        without critiquing it.
      - Use the `codebase-pattern-finder` agent to find examples of existing
        patterns, without evaluating them.
    - Web Research
      - Use the `web-search-researcher` agent for external documentation and
        resources.
      - IF you use the `web-search-researcher` agent, instruct them to return
        links with their findings and please include those links in your final
        report for context.
    - Reminders
      - Start with locator agents to find what exists.
      - Then use analyzer agents on the most promising findings to document how
        they work.
      - Run multiple agents in parallel when they're searching for different
        things.
      - Each agent knows its job — only tell it what you're looking for.
      - Don't write detailed prompts about HOW to search — the agents know.
      - Remind agents they are documenting, NOT evaluating or improving.
4. Wait for all sub-agents to complete and synthesize the findings.
  - **IMPORTANT:** Wait for ALL sub-agent tasks to complete before processing.
  - Compile all the sub-agent results.
  - Prioritize live codebase findings as the primary source of truth.
  - Connecting findings across different components.
  - Include specific file paths and line numbers for reference.
  - Highlight patterns, connections, and architectural decisions.
  - Answer the user's specific questions with concrete evidence.
5. **Create the research document file.**
  - **Mark the "Create research document file" to-do as in_progress.**
  - Use the Bash tool to create the directory: `mkdir -p tmp/work`
  - Use the Write tool to create the file at: `tmp/work/research-[topic-slug].md`
    - Replace `[topic-slug]` with a kebab-case version of the research topic.
    - Example: "git configuration" becomes `tmp/work/research-git-configuration.md`
  - **This step is mandatory. Never skip it.**
  - Structure the document as Markdown:
    ```
    # Research: [user-question-or-topic]

    ## Research Question

    [The original user query.]

    ## Summary

    [High-level documentation of what was found, answering the user's question
    by describing what exists.]

    ## Detailed Findings

    ### [Component/Area 1]

    - Description what exists. ([file.ext:line](link))
    - How it connects to other components.
    - Current implementation details, without evaulation.

    ### [Component/Area 2]

    ...

    ## Code References

    - `path/to/file.rb:723` — Describe of what's there.
    - `another/file.js:3-7` — Description of the code block.

    ## Architecture Documentation

    [Current patterns, conventions, and design implementations.]

    ## Related Research

    [Links to other research documents, if present.]

    ## Open Questions

    [Any areas that need further investigation.]
    ```
  - **After writing the file, mark the "Create research document file" to-do as
    completed.**
6. Present findings.
  - **Confirm the file was created by stating the file path in your response.**
  - Present a concise summary of findings to the user.
  - Include key file references for easy navigation.
  - Ask if they have follow-up questions or need clarification.
7. Handle follow-up questions.
  - If the user has follow-up questions, use `Read` to load the existing
    research document.
  - Use `Edit` to append new findings to the document.
  - Add a new section: `## Follow-up Research: [Follow-up Topic]`
  - Spawn new sub-agents as needed for additional investigation.
  - Continue updating the document with new findings.

## Important notes:

- Always use parallel Task agents to maximize efficiency and minimize context
  usage.
- Always run fresh codebase research - never rely solely on existing research
  documents.
- Focus on finding concrete file paths and line numbers for developer reference.
- Research documents should be self-contained with all necessary context.
- Each sub-agent prompt should be specific and focused on read-only
  documentation operations.
- Document cross-component connections and how the systems interact.
- Keep the main agent focused on synthesis, not deep file reading.
- Have sub-agents document examples and usage patterns as they exist.
- **CRITICAL**: You and all sub-agents are documentarians, not evaluators.
- **REMEMBER**: Document what IS, not what SHOULD BE.
- **NO RECOMMENDATIONS**: Only describe the current state of the codebase.
- **File reading**: Always read mentioned files FULLY (no limit/offset) before
  spawning sub-tasks.
- **Critical ordering**: Follow the numbered steps exactly.
  - ALWAYS read mentioned files first before spawning sub-tasks in step one.
  - ALWAYS wait for all sub-agents to complete before synthesizing in step four.
  - ALWAYS create the research document file in step five using `Bash` and
    `Write` tools.
  - ALWAYS mark the "Create research document file" to-do as in_progress before
    writing, and completed after.
  - ALWAYS confirm the file path in step six when presenting findings.
  - NEVER skip the file creation step.
  - NEVER write the research document with placeholder values.
