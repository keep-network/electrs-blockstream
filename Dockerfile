FROM rust:1.44.1-slim-buster as builder

WORKDIR /build

RUN apt-get update \
    && apt-get install -y --no-install-recommends clang=1:7.* cmake=3.*

COPY . .

RUN cargo build --release --bin electrs

# Create runtime image
FROM debian:buster-slim

WORKDIR /app

COPY --from=builder /build/target/release/electrs .

EXPOSE 3002
EXPOSE 60401

STOPSIGNAL SIGINT

ENTRYPOINT ["./electrs"]
