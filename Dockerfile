FROM golang:1.25

WORKDIR /app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.* .
COPY main.go .
RUN go mod download


RUN go build -v -o ./userapi 

CMD ["/app/userapi"]
