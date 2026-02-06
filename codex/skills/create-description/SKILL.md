---
name: create-description
description: Create a PR description following the PULL_REQUEST_TEMPLATE closely.
---

## Overview
You are going to write a PR description following the repos PULL_REQUEST_TEMPLATE closely.

Review the commits made in the branch related to the ticket at hand and find the relevant changes.

Under the test plan, keep it brief with manual testing instructions. Unit tests are a given, so do not mention them in this section. Keep that for any technical changes section.

## Style

Be concise and terse. No flattery, no internal monologue, just concise description of what is changed.

Under technical changes, do not write full sentences. Again, be terse and brief.

Sacrifice grammar for brevity. Do not use full sentences and many sub bullet points.

## Output

Following the PULL_REQUEST_TEMPLATE, return a markdown formatted code black that fills in the relevant portions.

Always wrap the response in code tag so the user can one-click copy and paste it. Do not ever paste it back raw
