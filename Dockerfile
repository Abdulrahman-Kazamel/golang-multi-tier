FROM golang:1.25 AS builder

WORKDIR /build

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.* .
COPY main.go .
RUN go mod download


RUN go build  -o ./userapi 


### staging
#FROM golang:1.25
FROM gcr.io/distroless/base-debian12
WORKDIR /app
COPY --from=builder /build/userapi .

CMD ["/app/userapi"]
