# Используем базовый образ Ubuntu
FROM ubuntu:latest

# Устанавливаем необходимые пакеты для сборки
RUN apt-get update && apt-get install -y \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*  # Удаляем кеш для уменьшения размера образа

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем код в контейнер
COPY . /app

# Выполняем сборку
RUN echo "gcc main.c -o main"

# Определяем команду, которая будет запускаться в контейнере
CMD ["./app/main"]
