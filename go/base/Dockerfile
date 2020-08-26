
FROM golang:1.13.5-alpine3.10 AS builder

RUN apk --no-cache add git

WORKDIR /go/build
#下载go的依赖包
RUN go get -d -v github.com/go-sql-driver/mysql

COPY app.go .

#编译，安装
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest as prod

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=0 /go/build .

CMD ["./app"]