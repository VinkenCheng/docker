FROM alpine:latest

WORKDIR /app

ENV VERSION 2.0.3
ENV GLIBC_VERSION 2.31-r0

RUN apk add --update curl unzip \
  && apk add libgcc libstdc++

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
  && wget -O glibc.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
  && wget -O glibc-bin.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
  && apk add glibc.apk glibc-bin.apk \
  && rm -rf glibc.apk glibc-bin.apk /etc/apk/keys/sgerrand.rsa.pub /var/cache/apk/*

RUN set -ex \
  && wget -O snell-server-v${VERSION}-linux-amd64.zip https://github.com/surge-networks/snell/releases/download/v${VERSION}/snell-server-v${VERSION}-linux-amd64.zip \
  && unzip snell-server-v${VERSION}-linux-amd64.zip \
  && cp snell-server /snell-server \
  && chmod +x /snell-server \
  && rm -rf /app

ENTRYPOINT ["/snell-server","-c","/config/snell-server.conf"]
