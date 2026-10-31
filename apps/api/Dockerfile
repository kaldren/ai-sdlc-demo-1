# Build context: repository root (uv workspace).
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim AS build
WORKDIR /app
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy UV_PYTHON_DOWNLOADS=never
COPY pyproject.toml uv.lock .python-version ./
COPY apps/api apps/api
COPY packages packages
COPY tools tools
RUN uv sync --frozen --no-dev --package leya-api

FROM python:3.13-slim-bookworm
RUN useradd --create-home --uid 10001 leya
WORKDIR /app
COPY --from=build --chown=leya:leya /app /app
ENV PATH="/app/.venv/bin:$PATH"
USER leya
EXPOSE 8000
HEALTHCHECK --interval=10s --timeout=3s --retries=5 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"
CMD ["uvicorn", "leya_api.main:app", "--host", "0.0.0.0", "--port", "8000"]
