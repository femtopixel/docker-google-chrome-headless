FROM debian:sid-slim as builder

ADD qemu-*-static /usr/bin/

FROM builder

LABEL maintainer="Jay MOULIN <jaymoulin@gmail.com> <http://twitter.com/moulinjay>"

ENV CHROME_DEBUG_PORT=9222
ARG ISARM=0

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg chromium --no-install-recommends --allow-unauthenticated && \
    groupadd -r chrome && useradd -r -g chrome -G audio,video chrome && \
    mkdir -p /home/chrome/reports && chown -R chrome:chrome /home/chrome

COPY entrypoint.sh /usr/bin/entrypoint

# Run Chrome non-privileged
USER chrome

# Drop to cli
ENTRYPOINT ["entrypoint"]
