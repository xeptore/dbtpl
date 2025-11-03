FROM docker.io/library/golang:1.23.5-trixie AS build

WORKDIR /app

COPY . .

ENV CGO_ENABLED=0

RUN go build -o dbtpl main.go

FROM gcr.io/distroless/static-debian12:nonroot AS runtime

COPY --chown=nonroot:nonroot --from=build /app/dbtpl /dbtpl

CMD [ "/dbtpl" ]
