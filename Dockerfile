FROM alpine:latest

WORKDIR /app

ENV VERSION 2.0.3

RUN apk add --update curl \
    && rm -rf /var/cache/apk/*

RUN set -ex \
  && curl -s -L -o snell-server-v${VERSION}-linux-amd64.zip https://github.com/surge-networks/snell/releases/download/v${VERSION}/snell-server-v${VERSION}-linux-amd64.zip \
  && unzip snell-server-v${VERSION}-linux-amd64.zip \
  && cp snell-server /snell-server \
  && chmod +x /snell-server \
  && rm -rf /app

ENTRYPOINT ["/snell-server","-c","/config/snell-server.conf"]
