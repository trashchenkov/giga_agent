#!/bin/sh
set -e
cd /app

# ждём, пока поднимется докер-демон
i=0
until docker info >/dev/null 2>&1; do
  i=$((i+1))
  if [ "$i" -gt 60 ]; then
    echo "Docker daemon didn't start in time" >&2
    exit 1
  fi
  echo "Waiting for Docker daemon..."
  sleep 2
done

# .docker.env из переменных окружения сервиса
printenv > .docker.env

# шаги из README
make init_files
make build_graph

# запуск как в инструкции
exec docker compose up
