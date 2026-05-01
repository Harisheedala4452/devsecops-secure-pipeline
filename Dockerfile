FROM python:3.12-slim

LABEL org.opencontainers.image.title="devsecops-secure-pipeline" \
  org.opencontainers.image.description="Secure Flask demo for DevSecOps CI/CD pipeline scanning."

ENV PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  APP_ENV=production \
  APP_VERSION=1.0.0 \
  PORT=5000

WORKDIR /app

# Install only runtime dependencies. Keeping build tools out of the final image
# reduces attack surface and keeps vulnerability scans quieter.
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
  && pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/

# Run as a dedicated non-root user so the app has fewer privileges if exploited.
RUN adduser --disabled-password --gecos "" --uid 10001 appuser \
  && chown -R appuser:appuser /app
USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health', timeout=2).read()" || exit 1

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--threads", "2", "app.main:app"]
