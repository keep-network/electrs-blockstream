FROM debian:buster-slim AS builder

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN wget -O bitcoin-core.tar.gz https://bitcoin.org/bin/bitcoin-core-0.20.0/bitcoin-0.20.0-x86_64-linux-gnu.tar.gz
RUN mkdir /bitcoin-core && tar -xzf bitcoin-core.tar.gz -C /bitcoin-core --strip-components=1

# Configure runtime container.
FROM debian:buster-slim

WORKDIR /app

EXPOSE 8332
EXPOSE 8333

COPY --from=builder /bitcoin-core/bin/bitcoind .

STOPSIGNAL SIGINT

ENTRYPOINT ["./bitcoind"]
