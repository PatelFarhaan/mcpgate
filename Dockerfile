# ── Production image ────────────────────────────────────────────
FROM python:3.12-slim AS production

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/

RUN addgroup --system mcpgate \
    && adduser --system --ingroup mcpgate mcpgate \
    && chown -R mcpgate:mcpgate /app

USER mcpgate

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]


# ── Test runner ─────────────────────────────────────────────────
# Includes test deps + full source. Not shipped — used only by
# docker-compose.test.yml via `target: test`.
FROM python:3.12-slim AS test

WORKDIR /app

COPY requirements.txt requirements-test.txt ./
RUN pip install --no-cache-dir -r requirements.txt -r requirements-test.txt

COPY app/ ./app/
COPY tests/ ./tests/
COPY pytest.ini ./

CMD ["pytest", "tests/", "-v"]
