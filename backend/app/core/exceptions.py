"""Typed application exceptions and the single API error envelope.

Every error response uses: {"error": {"code", "message", "details"}} —
no stack traces to clients (docs/03_BACKEND/BACKEND_ARCHITECTURE.md).
"""

from typing import Any


class AppError(Exception):
    """Base class for expected application errors."""

    status_code: int = 500
    code: str = "internal_error"
    message: str = "An unexpected error occurred."
    details: dict[str, Any] = {}


class UnauthenticatedError(AppError):
    status_code = 401
    code = "unauthenticated"
    message = "Authentication required."


class ForbiddenError(AppError):
    status_code = 403
    code = "forbidden"
    message = "You do not have access to this resource."


class NotFoundError(AppError):
    status_code = 404
    code = "not_found"
    message = "Resource not found."


class ValidationError(AppError):
    status_code = 422
    code = "validation_error"
    message = "The request payload is invalid."


def error_payload(err: AppError) -> dict[str, Any]:
    """Build the standard error envelope for an AppError."""
    return {
        "error": {
            "code": err.code,
            "message": err.message,
            "details": err.details,
        }
    }
