FROM golang:1.13.5-alpine3.10 AS builder

WORKDIR /build
#开启go mod proxy
ENV GOPROXY https://goproxy.io
#开启go mod
ENV GO111MODULE on

COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
#-ldflags="-s -w"
#-s: 省略符号表和调试信息
#-w: 省略DWARF符号表
#RUN GOOS=linux CGO_ENABLED=0 go build -ldflags="-s -w" -a -installsuffix cgo -o first .

RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -a -o first .

FROM alpine:3.10 AS final
WORKDIR /app
COPY --from=builder /build/first /app/
EXPOSE 8888
ENTRYPOINT ["/app/first"]