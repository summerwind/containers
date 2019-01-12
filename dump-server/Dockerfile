FROM golang:1.11 AS builder

WORKDIR /go/src/github.com/summerwind/dump-server/

COPY dump-server.go dump-server.go

RUN CGO_ENABLED=0 go build -o /bin/dump-server .

#################################################

FROM scratch

COPY --from=builder /bin/dump-server /bin/dump-server

CMD ["/bin/dump-server"]
