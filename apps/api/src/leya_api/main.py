from fastapi import FastAPI

from leya_api import __version__
from leya_api.settings import settings

app = FastAPI(title="Leya API", version=__version__)


@app.get("/health")
def health() -> dict[str, str]:
    """Liveness probe used by docker-compose, CI smoke tests and Azure Container Apps."""
    return {"status": "ok", "version": __version__, "environment": settings.environment}
