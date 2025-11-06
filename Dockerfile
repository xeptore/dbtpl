FROM docker.io/library/golang:1.25.4-trixie AS build

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

FROM docker.io/library/golang:1.25.4-alpine AS runtime

COPY --from=build /app/xo/dbtpl /dbtpl

ENTRYPOINT [ "/dbtpl" ]
