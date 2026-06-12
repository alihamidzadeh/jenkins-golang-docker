# Stage 1: Build
FROM docker.arvancloud.ir/golang:1.21-alpine AS builder
WORKDIR /app
COPY . .

# اول کدهای نوشته شده رو تست میکنیم (تست CI). اگه फेल بشه داکر ایمیج رو نمیسازه!
RUN go test -v

# بیلد کردن پروژه گو به یک فایل اجرایی به اسم myapp
RUN go build -o myapp main.go

# Stage 2: Run
FROM docker.arvancloud.ir/alpine:latest
WORKDIR /root/
# کپی کردن فایل اجرایی از مرحله قبل به این مرحله
COPY --from=builder /app/myapp .
EXPOSE 8080
CMD ["./myapp"]