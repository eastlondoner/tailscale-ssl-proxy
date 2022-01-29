# syntax=docker/dockerfile:1

FROM golang:1.17.6-alpine3.15 AS base
WORKDIR /go/src/github.com/eastlondoner/tailscale-ssl-proxy
# Install OS dependencies
RUN apk add --no-cache make git zip gcc
# Download go dependencies (should be cached unless go.mod changes)
COPY ./go.mod .
RUN go mod download

FROM base as clean
# Copy just the makefile
COPY ./Makefile .
ENTRYPOINT [ "make", "--jobs=4", "clean" ]

FROM base as build
# Copy all the source and run make
COPY . .
ENTRYPOINT [ "make", "build" ]

FROM build as upgrade-deps
ENTRYPOINT [ "make", "clean", "upgrade-deps" ]

FROM build as build-all
ENTRYPOINT [ "make", "--jobs=3", "build-all"]

FROM build AS test
# Install test dependencies
RUN apk add --no-cache gcc
ENTRYPOINT [ "make", "test" ]

FROM base AS release
# Install release dependencies
RUN go get github.com/goreleaser/goreleaser@v1.4.1
COPY ./install-godownloader.sh .
RUN ./install-godownloader.sh
# Copy all the source and run make
COPY . .
ENTRYPOINT [ "make", "release" ]
