import os
from datetime import datetime, timezone

from flask import Flask, jsonify

app = Flask(__name__)


APP_VERSION = os.getenv("APP_VERSION", "1.0.0")
APP_ENV = os.getenv("APP_ENV", "development")


@app.get("/")
def index():
    """Return a simple response that confirms the app is running."""
    return jsonify(
        {
            "message": "DevSecOps Secure Pipeline",
            "endpoints": ["/health", "/version"],
        }
    )


@app.get("/health")
def health():
    """Health endpoint used by Docker, CI smoke tests, and monitoring tools."""
    return jsonify({"status": "ok"})


@app.get("/version")
def version():
    """Expose safe runtime metadata without leaking secrets."""
    return jsonify(
        {
            "app": "devsecops-secure-pipeline",
            "version": APP_VERSION,
            "environment": APP_ENV,
            "hostname": os.getenv("HOSTNAME", "local"),
            "time": datetime.now(timezone.utc).isoformat(),
        }
    )
