FROM golang:1.9-alpine AS builder
RUN apk add --no-cache git g++ linux-headers
WORKDIR /go/src/github.com/tonistiigi/buildkit_http_sample
ADD main.go .
RUN go get -d -v .
RUN go build -o /usr/bin/buildkit_http_sample .

FROM tonistiigi/buildkit:standalone
COPY --from=builder /usr/bin/buildkit_http_sample /bin/
EXPOSE 8080
VOLUME /tmp
ENTRYPOINT ["buildkit_http_sample"]