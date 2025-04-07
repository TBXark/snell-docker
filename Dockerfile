FROM --platform=$BUILDPLATFORM alpine:latest AS builder
ARG TARGETARCH
RUN apk add --no-cache wget unzip 
RUN case "${TARGETARCH}" in \
    "amd64") \
        BINARY_URL="https://dl.nssurge.com/snell/snell-server-v4.1.1-linux-amd64.zip" ;; \
    "arm64") \
        BINARY_URL="https://dl.nssurge.com/snell/snell-server-v4.1.1-linux-aarch64.zip" ;; \
    *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1 ;; \
    esac  && \
    wget -O snell.zip "${BINARY_URL}" && \
    unzip snell.zip && \
    chmod +x snell-server && \
    rm snell.zip
    
FROM debian:latest
COPY --from=builder /snell-server /app/snell-server
WORKDIR /app
RUN chmod +x /app/snell-server
ENTRYPOINT [ "/app/snell-server" ]
CMD ["-c", "/app/snell-server.conf"]