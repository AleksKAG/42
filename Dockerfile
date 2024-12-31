# Указываем базовый образ с установленным Go
FROM golang:1.22.0 AS builder

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем go.mod и go.sum для установки зависимостей
COPY go.mod go.sum ./

# Устанавливаем зависимости
RUN go mod download

# Копируем остальные файлы проекта
COPY . .

# Собираем бинарный файл
RUN go build -o main .

# Используем минимальный базовый образ для финального контейнера
FROM debian:bullseye-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем бинарный файл из стадии сборки
COPY --from=builder /app/main .

# Указываем, какой порт будет открыт
EXPOSE 8080

# Запускаем приложение
CMD ["./main"]

# Ссылка на докер
https://hub.docker.com/repository/docker/alekskag/42/tags/v1/sha256:e6da93ad105798051d2dae74d46ad3163e016293021b121c2aa8aeff2d286a69
