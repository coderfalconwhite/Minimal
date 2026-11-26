"""Versioned API routers. Everything user-facing lives under /api/v1."""

from fastapi import APIRouter

from app.core.config import get_settings
from fastapi import Depends

router = APIRouter()


@router.get("/health")
def health(settings=Depends(get_settings)) -> dict:
    """Liveness probe: confirms the app booted and knows its environment."""
    return {"status": "ok", "app_env": settings.app_env}


# TODO(part-1): mount /me (identity from verified JWT), /me/profile,
# /me/delete-account and /analytics/events per
# docs/03_BACKEND/API_ENDPOINT_CATALOG.md once JWT verification lands.
