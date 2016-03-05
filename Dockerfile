FROM postgres:9.1
MAINTAINER Guillaume Hain <zedtux@zedroot.org>

ENV SWIFT_OS_AUTH_URL 'https://auth.cloud.ovh.net/v2.0'

RUN apt-get update && \
    apt-get install -y python-swiftclient cron && \
    rm -rf /var/lib/apt/lists/*

ADD pg2swift-start pg2swift-job pg2swift-build-swift-env /usr/local/bin/
RUN chmod +x /usr/local/bin/pg2swift-start \
  /usr/local/bin/pg2swift-job \
  /usr/local/bin/pg2swift-build-swift-env

ENTRYPOINT ["pg2swift-start"]
