# Compile binary

FROM rust:latest AS builder

RUN update-ca-certificates

WORKDIR /app

COPY . .

RUN cargo build --release


# Run binary

FROM gcr.io/distroless/cc-debian12 AS runtime

ENV ADDRESS "0.0.0.0:3000"

COPY --from=builder /app/target/release/static-web-server /

CMD ["/static-web-server"]