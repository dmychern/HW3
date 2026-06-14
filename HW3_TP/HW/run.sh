#!/bin/bash

mkdir -p data
mkdir -p local_data

case "$1" in
  build_generator)
    echo "Сборка образа генератора..."
    docker build -f Dockerfile.generator -t data-generator .
    ;;
    
  run_generator)
    echo "Запуск генератора данных..."
    docker run --rm -v "$(pwd)/data:/data" data-generator /data
    echo "Данные сгенерированы в data/data.csv"
    ;;
    
  create_local_data)
    echo "Локальная генерация данных..."
    python generate.py ./local_data
    echo "Данные сгенерированы в local_data/data.csv"
    ;;

  build_reporter)
    echo "Сборка образа аналитика..."
    docker build -f Dockerfile.reporter -t data-reporter .
    ;;

  run_reporter)
    echo "Запуск аналитика данных..."
    docker run --rm -v "$(pwd)/data:/data" data-reporter
    echo "Отчет сгенерирован в data/report.html"
    ;;

  structure)
    echo "Структура проекта:"
    find . -maxdepth 3 -not -path '*/.*'
    ;;

  clear_data)
    echo "Очистка данных в папке data/..."
    rm -f data/*.csv data/*.html
    ;;

  inside_generator)
    echo "Содержимое /data внутри генератора:"
    docker run --rm -v "$(pwd)/data:/data" data-generator /data ls /data
    ;;

  inside_reporter)
    echo "Содержимое /data внутри аналитика:"
    docker run --rm -v "$(pwd)/data:/data" --entrypoint ls data-reporter /data
    ;;
    
  *)
    echo "Использование: $0 {build_generator|run_generator|create_local_data|build_reporter|run_reporter|structure|clear_data|inside_generator|inside_reporter}"
    exit 1
    ;;
esac