# Stage 1: Build
FROM docker.arvancloud.ir/golang:1.21-alpine AS builder
WORKDIR /app
COPY . .

RUN go test -v

RUN go build -o myapp main.go

# Stage 2: Run
FROM docker.arvancloud.ir/alpine:latest
WORKDIR /root/
COPY --from=builder /app/myapp .
EXPOSE 8080
CMD ["./myapp"]