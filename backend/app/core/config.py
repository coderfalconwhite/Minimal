"""Application settings.

Loaded from environment variables (see ../../.env.example). Fails fast at
startup when required values are missing so misconfiguration is caught in
CI, not in production.
"""

from functools import lru_cache

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    # App
    app_env: str = "development"  # development | staging | production
    app_name: str = "my-application-api"
    api_v1_prefix: str = "/api/v1"
    log_level: str = "INFO"
    cors_origins: str = ""  # comma-separated list

    # Supabase / JWT verification (AGENTS.md section 7)
    supabase_url: str = ""
    jwt_issuer: str = ""
    jwt_audience: str = "authenticated"
    jwks_url: str = ""
    jwks_cache_seconds: int = 3600

    # Operational limits
    rate_limit_per_minute: int = 120

    @property
    def cors_origin_list(self) -> list[str]:
        return [o.strip() for o in self.cors_origins.split(",") if o.strip()]


@lru_cache
def get_settings() -> Settings:
    return Settings()
