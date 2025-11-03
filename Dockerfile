FROM docker.io/library/golang:1.25.3-trixie AS build

WORKDIR /app

COPY xo/ xo/

ENV CGO_ENABLED=0

ARG VERSION

RUN go build \
    -C ./xo/ \
    -buildvcs=true \
    -trimpath \
    -ldflags="-compressdwarf=true -extldflags=-static -s -w -X main.name=dbtpl -X main.version=${VERSION}" \
    -o dbtpl  \
    main.go

FROM gcr.io/distroless/static-debian12:nonroot AS runtime

COPY --chown=nonroot:nonroot --from=build /app/xo/dbtpl /dbtpl

ENTRYPOINT [ "/dbtpl" ]
