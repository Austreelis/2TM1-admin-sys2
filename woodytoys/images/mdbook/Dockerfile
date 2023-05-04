# syntax = docker/dockerfile:1.4

################################################################################
FROM ubuntu:22.04 AS builder

WORKDIR /root

# Install deps
RUN set -eux; \
  apt update; \
  apt install -y --no-install-recommends \
  curl ca-certificates gcc libc6-dev pkg-config libssl-dev

# Install mdbook
ENV PATH=${PATH}:/root/
RUN set -eux; \
  curl --location --fail \
    "https://github.com/rust-lang/mdBook/releases/download/v0.4.28/mdbook-v0.4.28-x86_64-unknown-linux-musl.tar.gz" \
    --output /usr/bin/mdbook.tar.gz; \
  tar -xvzf /usr/bin/mdbook.tar.gz -C /usr/bin

# Copy sources and build them
COPY book book
RUN mdbook build book -d build

################################################################################
FROM httpd:latest AS mdbook

# httpd is based on debian-slim
RUN set -eux; \
  apt update; \
  apt install -y --no-install-recommends curl

# Copy build from builder
COPY --from=builder /root/book/build /usr/local/apache2/htdocs

