FROM docker.io/library/golang:1.25.3-trixie AS build

WORKDIR /app

COPY xo/dbtpl/ .

ENV CGO_ENABLED=0

RUN go build -C ./xo/dbtpl -o dbtpl main.go

FROM gcr.io/distroless/static-debian12:nonroot AS runtime

COPY --chown=nonroot:nonroot --from=build /app/xo/dbtpl/dbtpl /dbtpl

CMD [ "/dbtpl" ]
