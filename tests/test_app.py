from app.main import app


def test_index_route_lists_available_endpoints():
    client = app.test_client()

    response = client.get("/")
    payload = response.get_json()

    assert response.status_code == 200
    assert payload["message"] == "DevSecOps Secure Pipeline"
    assert "/health" in payload["endpoints"]
    assert "/version" in payload["endpoints"]


def test_health_route_returns_ok():
    client = app.test_client()

    response = client.get("/health")

    assert response.status_code == 200
    assert response.get_json() == {"status": "ok"}


def test_version_route_returns_safe_metadata():
    client = app.test_client()

    response = client.get("/version")
    payload = response.get_json()

    assert response.status_code == 200
    assert payload["app"] == "devsecops-secure-pipeline"
    assert "version" in payload
    assert "hostname" in payload
    assert "time" in payload
