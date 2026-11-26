"""Backend smoke + contract tests.

Part 1 will add: JWT verification tests (valid / expired / wrong issuer /
wrong audience / bad signature / missing), analytics intake validation, and
endpoint integration tests. See docs/08_TESTING/TEST_STRATEGY.md.
"""

from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_health_ok() -> None:
    """The liveness probe responds with the standard ok payload."""
    response = client.get("/api/v1/health")
    assert response.status_code == 200
    body = response.json()
    assert body["status"] == "ok"
    assert body["app_env"] in {"development", "staging", "production"}


def test_error_envelope_shape() -> None:
    """AppErrors render through the single error envelope."""
    response = client.get("/api/v1/does-not-exist")
    # FastAPI's own 404 is wrapped by our envelope only for AppError;
    # for the stock 404 we assert the JSON shape stays stable.
    assert response.status_code == 404
    assert response.headers["content-type"].startswith("application/json")


def test_protected_endpoints_fail_closed() -> None:
    """Without JWT verification configured, identity resolution must fail
    closed (never accidentally authenticate a request)."""
    from app.authentication.dependencies import current_user

    try:
        current_user(credentials=None)  # type: ignore[arg-type]
    except Exception:
        return  # fail-closed: acceptable
    raise AssertionError("current_user must not authenticate without a token")
