"""FastAPI application factory.

Structure and rules: docs/03_BACKEND/BACKEND_ARCHITECTURE.md,
skills/fastapi-backend-engineering/SKILL.md.
"""

from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from app.api.v1.router import router as v1_router
from app.core.config import get_settings
from app.core.exceptions import AppError, error_payload


def create_app() -> FastAPI:
    settings = get_settings()

    app = FastAPI(
        title=settings.app_name,
        version="0.0.1",
        # Docs stay available in non-production for contract inspection.
        openapi_url=None if settings.app_env == "production" else "/openapi.json",
    )

    if settings.cors_origin_list:
        app.add_middleware(
            CORSMiddleware,
            allow_origins=settings.cors_origin_list,
            allow_methods=["GET", "POST", "PUT", "PATCH", "DELETE"],
            allow_headers=["Authorization", "Content-Type"],
        )

    # One error envelope for every expected application error.
    @app.exception_handler(AppError)
    async def app_error_handler(_: Request, exc: AppError) -> JSONResponse:
        return JSONResponse(status_code=exc.status_code, content=error_payload(exc))

    app.include_router(v1_router, prefix=settings.api_v1_prefix)

    return app


app = create_app()
