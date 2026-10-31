# One-command entry points. Every target exits non-zero on failure.
.DEFAULT_GOAL := help
WEB := apps/web

.PHONY: help env reset install lint typecheck test build check up down logs smoke ingest eval-rag

help: ## List targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-10s %s\n", $$1, $$2}'

install: ## Install Python (uv) and web (npm) dependencies
	uv sync --frozen
	cd $(WEB) && npm ci

lint: ## ruff + eslint
	uv run ruff check .
	uv run ruff format --check .
	cd $(WEB) && npm run lint

typecheck: ## mypy (strict) + tsc
	uv run mypy
	cd $(WEB) && npm run typecheck

test: ## pytest + vitest
	uv run pytest -q
	cd $(WEB) && npm test

build: ## Production build of the storefront
	cd $(WEB) && npm run build

check: lint typecheck test build ## Everything CI runs. Must pass before any task is "done".
	@echo "CHECK PASSED"

env: ## Create .env from .env.example with a random local DB password (no-op if it has one)
	@test -f .env || cp .env.example .env
	@grep -q '^LEYA_DB_PASSWORD=..*' .env || { \
	  pw=$$(openssl rand -hex 24); \
	  grep -v '^LEYA_DB_PASSWORD=' .env > .env.tmp && echo "LEYA_DB_PASSWORD=$$pw" >> .env.tmp && mv .env.tmp .env; \
	  echo 'Generated LEYA_DB_PASSWORD in .env'; }

up: env ## Start db + api + web locally (docker compose)
	docker compose up -d --build --wait

down: ## Stop the local stack
	docker compose down

reset: ## Stop the stack and DELETE the local DB volume (needed if LEYA_DB_PASSWORD changed)
	docker compose down -v

logs: ## Tail local stack logs
	docker compose logs -f

smoke: ## Smoke-test a running stack (API_URL, WEB_URL overridable)
	curl -fsS $${API_URL:-http://localhost:8000}/health && echo
	curl -fsS -o /dev/null -w "web %{http_code}\n" $${WEB_URL:-http://localhost:3000}/
	docker compose exec -T db psql -U leya -d leya -tAc "SELECT 'pgvector ' || extversion FROM pg_extension WHERE extname = 'vector'"
	docker compose exec -T api python -c "from sqlalchemy import create_engine, text; from leya_api.settings import settings; print('api->db', create_engine(settings.database_url).connect().execute(text('SELECT 1')).scalar())"

ingest: ## Load documents into pgvector (arrives with the pilot change)
	@echo "Not implemented yet: delivered by the pilot intent (policy Q&A assistant)." && exit 1

eval-rag: ## Run the RAG golden-set evals (arrives with the pilot change)
	@echo "Not implemented yet: delivered by the pilot intent (policy Q&A assistant)." && exit 1
