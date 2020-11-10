FROM alpine:latest

WORKDIR /app

ENV VERSION 0.20.0

RUN apk add --update curl \
    && rm -rf /var/cache/apk/*

RUN set -ex \
  && curl -s -L frp_${VERSION}_linux_amd64.tar.gz https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz | tar -zx \
  && cd frp_${VERSION}_linux_amd64 \
  && cp frps /frps \
  && cp frpc /frpc \
  && chmod +x /frps \
  && chmod +x /frpc \
  && rm -rf /app

EXPOSE 6400 6500

ENTRYPOINT ["/frps","-c","/config/frps.ini"]
