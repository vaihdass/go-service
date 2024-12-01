# Build the Go binary
FROM golang:1.23.2 as build_sales-api
ENV CGO_ENABLED 0
ARG BUILD_REF

COPY . /app

WORKDIR /app
RUN go build -o service -ldflags "-X main.build=${BUILD_REF}"

FROM alpine:3.20
ARG BUILD_DATE
ARG BUILD_REF
COPY --from=build_sales-api /app/service /app/service

WORKDIR /app
CMD ["./service"]

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="sales-api" \
      org.opencontainers.image.authors="Georgiy Vaihdass <kozobrodovg@yandex.ru>" \
      org.opencontainers.image.source="https://github.com/vaihdass/go-service" \
      org.opencontainers.image.revision="${BUILD_REF}" \
      org.opencontainers.image.vendor="Enk"
