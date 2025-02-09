FROM python:3.10-slim

WORKDIR /app

COPY pyproject.toml uv.lock ./

RUN pip install uv

RUN uv pip install -r pyproject.toml --system

ENV PYTHONPATH="/app"

COPY . .
