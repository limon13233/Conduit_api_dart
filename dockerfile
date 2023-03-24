# Base image
FROM dart

# Set environment variables
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD 1
ENV POSTGRES_HOST db
ENV POSTGRES_PORT 5432
ENV POSTGRES_DB postgres

# Используем официальный образ с Dart SDK
FROM dart

# Установка необходимых зависимостей
RUN apt-get update && apt-get install -y \
    git \
    libssl-dev \
    zlib1g-dev

# Создание директории приложения в контейнере
RUN mkdir /app
WORKDIR /app

# Копирование исходного кода приложения
COPY . .

# Установка зависимостей приложения
RUN dart pub get

# Компиляция приложения
RUN dart compile exe bin/main.dart -o /app/bin/conduit_api.dart

# Команда для запуска приложения в контейнере
CMD ["/app/bin/conduit_api.dart"]