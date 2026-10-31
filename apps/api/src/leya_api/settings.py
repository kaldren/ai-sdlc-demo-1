from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Runtime configuration, read from environment variables (and `.env` locally)."""

    model_config = SettingsConfigDict(env_file=".env", env_prefix="LEYA_", extra="ignore")

    environment: str = "local"
    # No credentials in code: set LEYA_DATABASE_URL (docker-compose builds it from .env).
    database_url: str = "postgresql+psycopg://leya@localhost:5432/leya"


settings = Settings()
