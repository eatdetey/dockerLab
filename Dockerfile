FROM tiangolo/uvicorn-gunicorn-fastapi:python3.11-slim AS builder

WORKDIR /app

COPY pyproject.toml ./
COPY . .

RUN pip install .

FROM tiangolo/uvicorn-gunicorn-fastapi:python3.11-slim

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /app /app

EXPOSE 8111

CMD ["sh", "-c", "uvicorn src.main:app --host 127.0.0.1 --port 8051"]
