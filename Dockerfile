FROM alpine:latest

# Maintainer.
MAINTAINER Pedro Branco <branco@uphold.com> (@pedrobranco)

# Add a user to avoid running node as `root`.
RUN adduser -S ethereum

# Install gosu.
ENV GOSU_VERSION 1.7
RUN set -x \
    && apk add --no-cache --virtual build-dependencies openssl gnupg \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(uname -m | sed 's/x86_64/amd64/g')" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(uname -m | sed 's/x86_64/amd64/g').asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apk del build-dependencies

# Install geth.
ENV GETH_VERSION=1.3.6 GETH_DATA=/home/ethereum/.geth
RUN set -x \
    && apk add --no-cache --virtual build-dependencies go gmp-dev openssl make gcc musl-dev \
    && mkdir -p /tmp/build/ \
    && cd /tmp/build/ \
    && wget -O /tmp/build/geth-$GETH_VERSION.tar.gz "https://github.com/ethereum/go-ethereum/archive/v$GETH_VERSION.tar.gz" \
    && tar -zxf geth-$GETH_VERSION.tar.gz \
    && cd go-ethereum-$GETH_VERSION/ \
    && make \
    && cp ./build/bin/geth /usr/local/bin/geth \
    && chmod +x /usr/local/bin/geth \
    && rm -rf /tmp/build/ \
    && apk del build-dependencies

VOLUME ["/home/ethereum/.geth"]

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8545 30303

CMD ["geth"]
