---
name: debug-session
description: Start a debug session to investigate problems in a codebase using thorough console logging and analysis.
---

## Overview
The `debug-session` skill is designed to help developers investigate and resolve issues in a codebase by providing detailed console logging and analysis.


### Process

Start by clarifying the problem with the user if not provided. Ensure you understand the context and the specific issue they are facing.

1. **Gather Information**: Ask the user for details about the problem, including error messages, expected vs. actual behavior, and any relevant code locations. Skip this if the user has already provided sufficient information for you to dig in.
2. **Hypothesize**: Based on the information provided, form hypotheses about what might be causing the issue. Consider common pitfalls and edge cases related to the problem. Create a few hypotheses to test and output them to the user.
3. **Test Hypotheses**: For each hypothesis, implement console logging and stringify the objects to gather more information. Each log statement MUST correspond to a given hypothesis and further illuminate the problem and if it could be caused by the hypothesis.
4. **User tests**: After updating the code with your new logging and instrumentation, ask the user to run the workflow and share the log outputs.
5. **Analyze Logs**: Review the logs provided by the user to identify patterns, anomalies, or specific points of failure. Use this information to refine your hypotheses and narrow down the potential causes of the issue.
6. **Iterate**: Repeat the process of hypothesizing, testing, and analyzing until you have identified the root cause of the problem. Once the issue is identified, provide a clear explanation of the cause and suggest potential solutions or next steps for the user to resolve the issue. Remove hypothesis that have been ruled out and update the user on the remaining hypotheses and next steps.


## Rules

* Every log statement MUST be associated with a hypothesis and is included in the log statement. (e.g., "H1:")
* Every log statement MUST have a prefix that allows for easy filtering, unrelated to the hypothesis, such as a unique identifier or a consistent format. (e.g., "DEBUG-SESSION:")
* Do NOT log objects, always JSON stringify them for easier copy pasting.
