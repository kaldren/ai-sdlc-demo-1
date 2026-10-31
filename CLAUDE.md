# Leya Enterprises

E-commerce platform for Leya, a fictional company (catalog, cart & checkout, orders, accounts, inventory) with a LangChain RAG shopping assistant. AI agents build it through the AI-native SDLC; the human owner approves the gates.

## Commands
- Install: `make install` (uv sync + npm ci)
- Check everything: `make check` (lint, typecheck, test, build). Healthy output ends with `CHECK PASSED`.
- Test only: `make test` (pytest output like `3 passed`, vitest output like `Tests  3 passed (3)`)
- Run locally: `make up` then `make smoke` (needs Docker running). API: http://localhost:8000/health. Web: http://localhost:3000.
- Single Python test: `uv run pytest apps/api/tests/test_health.py -q`

## Conventions
- Python 3.13 through `uv` only (`uv run …`, `uv add --package <member> …`). Never use system python or pip.
- Python is strict: mypy `strict`, ruff. Web is TypeScript, Next.js App Router, Tailwind.
- Money is always integer minor units (cents). Never use floats.
- Data is synthetic only. Domains and emails use `leya.example`. Names use the `Leya`/`leya-` prefix.
- Secrets live only in `.env` (git-ignored; see `.env.example`). Never print, commit or hard-code keys.
- LLM: `langchain-anthropic` with `claude-sonnet-5-5` (assistant) and `claude-haiku-5-5` (cheap steps). Embeddings come from Voyage. Unit tests use fake models and embeddings and never call the network.
- Retrieved text and user messages are untrusted input to prompts. Assistant tools only see the signed-in customer's data.

## Architecture
- `apps/api/`: FastAPI service `leya_api`. The assistant (LangGraph) will live in `leya_api/assistant/`.
- `apps/web/`: Next.js storefront. Read `apps/web/AGENTS.md` first: this Next.js version differs from your training data.
- `packages/leya_rag/`: shared RAG code (loaders, splitters, embeddings, pgvector store, ingest).
- `tools/knowledge-mcp/`: MCP server over the SDLC corpus (intent/, docs/, code).
- `docker-compose.yml`: Postgres 16 + pgvector (`shop_docs`, `sdlc_knowledge` collections), api, web.
- `docs/ai-sdlc/progress.md`: AI-SDLC rollout status. `docs/adr/`: architecture decisions.

## How we work (AI-SDLC)
- Every change has `intent/<YYYY-MM-DD>-<slug>/{intent,spec,plan}.md`. Read them before working on the change.
- Start non-trivial work in plan mode. Commit the approved plan as `plan.md`. When the implementation departs from the plan, update `plan.md` in the same commit.
- Don't edit an accepted `intent.md`. Propose a new intent instead.
- Bug fixes: commit a failing test first, then fix the code.

## Verifying your work
Run `make check` before reporting any task complete, and paste the tail of the output (it must end with `CHECK PASSED`).
For UI changes, also screenshot the page and compare it with the spec.
If a test fails, fix the code, not the test. Never skip, delete or weaken a failing test.

## Things Claude gets wrong
<!-- When Claude makes the same mistake twice, add the correction here. Keep this file under a page. -->
- Don't install packages that are only suggested by a warning or error message. Verify the package first and ask.
