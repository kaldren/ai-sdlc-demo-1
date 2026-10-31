# AI-SDLC progress — Leya Enterprises (ai-sdlc-demo-1)

Coach: `/ai-sdlc` (status: `/ai-sdlc status`, continue: `/ai-sdlc next`)
Started: 2026-10-31

## Profile
- Detected (2026-10-31): new repo with a GitHub remote (`kaldren/ai-sdlc-demo-1`), no CI, no Claude config. jq, gh, uv, Docker and Node 26 are installed. System Python 3.15, so the project pins 3.13 via uv.
- Project state: new. Phase 0 includes the stack scaffold.
- Team: solo. The owner holds every role. Artifacts and gate order stay; each sign-off becomes a deliberate self-review before merge. Skipped: MDM managed settings, policy-owner routing, org marketplaces.
- Ambition: full closed loop. The roadmap runs to Phase 7.
- Tracker / source of truth: GitHub Issues, with the repo as source of truth. Every `intent.md` carries `Tracker: #<issue>`.
- Roles: product owner, tech lead, release manager and platform engineer are all kaldren.
- Policies to encode: security (PII-shaped synthetic data, secrets, prompt injection), API conventions, RAG/LLM conventions. First skill: `leya-security`.
- Data sensitivity: synthetic only, but PII-shaped (customer accounts, orders), so it's treated as PII. Secrets hooks come early (Phase 3).
- CI: GitHub Actions. Model access: Anthropic API (`claude-sonnet-5-5`, `claude-haiku-5-5`) plus Voyage embeddings.
- UI: Next.js storefront. The visual loop runs through Playwright (MCP for sessions, screenshots in CI).
- Environments: local (docker-compose) → Azure staging → Azure prod (Container Apps + Postgres Flexible Server with pgvector).
- Metrics store / chat: CI + git data first, then App Insights. No chat tool, so P14 Claude Tag is skipped.
- Protected paths (Phase 3): applied Alembic migrations, `infra/azure/prod.*`, merged `intent/**/intent.md`.
- LangChain scope: (1) a product shopping assistant (RAG → LangGraph agent with tools) and (2) an SDLC knowledge index exposed as an MCP server.
- Pilot change: "Ask about our return/shipping policy". An LCEL RAG chain over `docs/policies/*.md` with citations, which answers "I don't know" when it has no basis.

## Roadmap
Legend: ✅ done · 🟡 in progress/blocked · ⬜ not started · ➖ skipped (reason)

### Phase 0 — Prerequisites
- ✅ Git repo + GitHub remote
- ✅ jq installed
- ✅ One-command check: `make check` → `CHECK PASSED` (ruff, mypy strict, pytest, eslint, tsc, vitest, next build)
- ✅ Local stack `make up && make smoke` (2026-10-31, OrbStack): api /health 200, web 200, pgvector 0.8.7, api container runs as non-root
- ✅ Minimal CI: `.github/workflows/ci.yml` (`make check` + docker stack smoke)
- ⬜ API keys in `.env` and GitHub secrets (You do)

### Phase 1 — Foundations
- ✅ P4 CLAUDE.md (42 lines, commands verified)
- 🟡 P8 Feedback loop: the verification block is in CLAUDE.md, and Playwright MCP is declared in `.mcp.json`. Still to do: approve the MCP server when Claude Code prompts, then the "done when" check in a fresh session.
- ✅ P1 Intent home + template (`intent/_TEMPLATE.md`, `intent/README.md`)

### Phase 2 — Artifact chain (pilot: policy Q&A)
- ⬜ P1 Pilot intent.md + GitHub Issue
- ⬜ P5 First policy skill `leya-security` (then `leya-api-conventions`, `leya-rag-conventions`)
- ⬜ P2 spec.md
- ⬜ P3 plan.md + implementation (LangChain: loaders → splitter → Voyage embeddings → PGVector → retriever → LCEL chain; `make ingest`, `make eval-rag`)

### Phase 3 — Guardrails
- ⬜ P6 Hooks: block-secrets, protect-paths, protect-tests (`AI_SDLC_FIX_MODE`), format-on-edit (ruff/prettier)
- ⬜ Permissions allowlist (`make *`, `uv run pytest`, `npm test`)
- ⬜ P3 Auto mode for routine work

### Phase 4 — Scale and review
- ⬜ P7 Subagents (verifier / `sdlc:code-reviewer`, researcher, code-simplifier) + worktrees
- ⬜ P10 REVIEW.md + `claude-review.yml` + `@claude` fix loop + `/babysit-pr`
- ⬜ Branch protection on main (You do)

### Phase 5 — Gates and pipeline
- ⬜ Azure: subscription, resource group, OIDC credential, GitHub `production` environment with required reviewer (You do)
- ⬜ Bicep: ACA staging + prod, Postgres Flexible Server (vector), ACR, App Insights
- ⬜ P11 `production-gate.sh` hook
- ⬜ P12 `deploy.yml` (staging auto, prod approved), `triage-failed-build.yml`, rollback rehearsed in staging
- ⬜ Automated triggers: merged intent → spec PR; approved spec → plan session

### Phase 6 — Test the agent and the assistant
- ⬜ P9 `agent-evals.yml` (~10 tasks, nightly + on CLAUDE.md / `.claude/**` changes)
- ⬜ RAG evals `rag-evals.yml` (hit@k, faithfulness; gating)

### Phase 7 — Close the loop
- ⬜ P13 `monitoring/bands.yaml` + `detect.py` (CI failure rate → 5xx → assistant faithfulness), `control-loop.yml`, agent writes incident intents
- ➖ P14 Claude Tag: no chat tool

### Feature backlog (each item goes intent → spec → plan)
catalog API + seed data → storefront catalog pages → product search assistant (hybrid retrieval) → cart & checkout (mock payment) → accounts & orders → assistant tools agent (LangGraph) → knowledge MCP → inventory

## Decisions log
- 2026-10-31: Python pinned to 3.13 via uv. System 3.15 is too new for some wheels.
- 2026-10-31: One Postgres + pgvector holds both shop data and vector collections. Simplest to run, and allows hybrid SQL + vector search.
- 2026-10-31: Voyage for embeddings, because Anthropic has no embeddings API. Unit tests use fake embeddings and models (no network).
- 2026-10-31: Kept `httpx` for FastAPI's TestClient. Starlette suggests `httpx2`, but it hasn't been verified. Revisit later.
- 2026-10-31: `@types/node` bumped to ^24 (Vitest 5 peer requirement). The web Docker image uses node:24.
- 2026-10-31: LangChain/LangGraph dependencies are not added during scaffolding. They arrive with the pilot change through the loop.

- 2026-10-31: There are no literal DB credentials in the repo (GitGuardian flagged the first scaffold). `make env` generates a random `LEYA_DB_PASSWORD` into `.env`, and compose and CI use it.
- 2026-10-31: `typecheck` runs `next typegen` first. Next's global route types (`LayoutProps`) only exist after generation, and a fresh CI checkout has none.

## Blockers / "You do" items outstanding
- [ ] Create Anthropic + Voyage API keys and put them in `.env` (copy `.env.example`)
- [ ] `gh secret set ANTHROPIC_API_KEY` and `gh secret set VOYAGE_API_KEY`
- [ ] Approve the project MCP server `playwright` (from `.mcp.json`) when Claude Code prompts
- [ ] Optional: LangSmith account for tracing while learning

## Metrics baselines
<!-- metric — baseline value — date — source -->
- First-pass CI success rate (agent changes): no data yet. Source: `gh run list`.
- PR cycle time: no data yet. Source: GitHub PR API.

## Recurring
- Monthly: tune REVIEW.md (rate findings, cap nits). Next: after Phase 4.
- Rollback rehearsal in staging. Last: never (Phase 5).
