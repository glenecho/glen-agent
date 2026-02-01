FROM rust:1-slim AS builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM debian:stable-slim
WORKDIR /app
COPY --from=builder /app/target/release/glen-agent /usr/local/bin/glen-agent
ENTRYPOINT ["glen-agent"]
