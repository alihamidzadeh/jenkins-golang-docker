# Stage 1: Build
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
# بیلد کردن پروژه گو به یک فایل اجرایی به اسم myapp
RUN go build -o myapp main.go

# Stage 2: Run
FROM alpine:latest
WORKDIR /root/
# کپی کردن فایل اجرایی از مرحله قبل به این مرحله
COPY --from=builder /app/myapp .
EXPOSE 8080
CMD ["./myapp"]