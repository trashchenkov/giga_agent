#!/bin/sh
set -e
cd /app

# 1) Подготовим .docker.env из переменных окружения Koyeb
# (это заменяет ручное "заполнить .docker.env")
printenv > .docker.env

# 2) Повторим шаги README в "чужом" временном контейнере Python,
# чтобы не ставить Python/make внутрь базового образа Koyeb:
docker run --rm -v "$(pwd)":/work -w /work python:3.11-slim bash -lc "
  apt-get update && apt-get install -y make && \
  pip install --no-cache-dir langgraph-cli && \
  make init_files && \
  make build_graph
"

# 3) Запуск как в инструкции
exec docker compose up
