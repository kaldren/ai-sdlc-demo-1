# Intent home

Each change to Leya starts here. It gets one folder, `intent/<YYYY-MM-DD>-<slug>/`, and that folder ends up holding the whole artifact chain:

1. `intent.md`: the problem in the originator's own words (from `_TEMPLATE.md`). It contains no implementation decisions.
2. `spec.md`: requirements and design, written under the policy skills in `.claude/skills/`.
3. `plan.md`: the Claude Code plan-mode output that the engineer approved.

**Proposing an intent:** brainstorm it with Claude (`/ai-sdlc intent`), then commit it on a branch `intent/<slug>` with `Status: draft`. Open a PR that links the GitHub Issue named in `Tracker:`.

**Statuses:** `draft` → `accepted` (PR merged) | `rejected` (PR closed, with the reason in the PR).

**Who accepts:** the product owner. In this repo that's the repo owner (kaldren), who works solo. Re-read the intent after a break before merging. That merge is the gate.

Accepted intents are never edited. If a change of direction is needed, it becomes a new intent. Agents that detect incidents (Stage 6) write intents here too, with `Source: alert: …`.
