#!/bin/sh
set -e
cd /app

# ждём docker-daemon (в образе Koyeb он стартует фоном)
i=0
until docker info >/dev/null 2>&1; do
  i=$((i+1))
  [ "$i" -gt 60 ] && { echo "Docker daemon didn't start in time" >&2; exit 1; }
  echo "Waiting for Docker daemon..."
  sleep 2
done

# .docker.env из переменных окружения сервиса
printenv > .docker.env

# проверим, что langgraph доступен
langgraph --version || { echo "langgraph not found"; exit 1; }

# шаги из README
make init_files
make build_graph

# запуск как в инструкции
exec docker compose up
