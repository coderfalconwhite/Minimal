"""Supabase access-token verification (JWT via JWKS).

Security rule (AGENTS.md section 7): FastAPI must verify the Supabase access
token rather than trusting a user ID sent by Flutter. Signature, issuer,
audience and expiration are all checked; identity is derived ONLY from the
verified token.

Scaffold note: this module wires the dependency interface and the strict
validation order. The JWKS fetch itself (caching, key rotation) is completed
in Part 1 together with its forged/expired/wrong-audience tests. Until
SUPABASE_URL/JWKS settings are configured, protected endpoints fail closed
with 500 (misconfiguration), never open.
"""

from dataclasses import dataclass

from fastapi import Depends
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer

from app.core.config import Settings, get_settings
from app.core.exceptions import UnauthenticatedError

_bearer = HTTPBearer(auto_error=False)


@dataclass(frozen=True)
class AuthenticatedUser:
    """Identity derived from a verified Supabase access token."""

    id: str
    is_anonymous: bool
    claims: dict


def _decode_and_verify(
    token: str, settings: Settings
) -> AuthenticatedUser:
    """Verify a Supabase JWT and return the authenticated identity.

    Validation order (all must pass):
    1. Signature against the Supabase JWKS endpoint (with key caching).
    2. Issuer matches settings.jwt_issuer.
    3. Audience matches settings.jwt_audience.
    4. Expiration is in the future.
    """
    # TODO(part-1): implement JWKS fetch + signature verification
    # (python-jose or pyjwt with a cached JWKS client) and the four checks
    # above. Tests must cover: valid token, expired, wrong issuer, wrong
    # audience, bad signature, anon-key-signed token.
    raise UnauthenticatedError(
        details={"reason": "jwt_verification_not_configured"}
    )


def current_user(
    credentials: HTTPAuthorizationCredentials | None = Depends(_bearer),
    settings: Settings = Depends(get_settings),
) -> AuthenticatedUser:
    """FastAPI dependency: require a valid Supabase access token."""
    if credentials is None or not credentials.credentials:
        raise UnauthenticatedError(details={"reason": "missing_bearer_token"})
    return _decode_and_verify(credentials.credentials, settings)
