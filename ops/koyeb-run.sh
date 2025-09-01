#!/bin/sh
set -e
cd /app

# 1) Сформируем .docker.env из переменных окружения Koyeb
# (хватает для "Заполнить .docker.env"; при желании можно положить свой шаблон и дополнять его)
printenv > .docker.env

# 2) Повторяем шаги из инструкции репо
# cp файлов обычно делает make init_files; если в Makefile это уже есть — ок
make init_files
make build_graph

# 3) Как в README
exec docker compose up
