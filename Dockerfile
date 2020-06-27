FROM debian:stable-slim as builder

ADD qemu-*-static /usr/bin/

FROM builder

ARG VERSION=77.0.3854.3
ARG REVISION=678702
LABEL maintainer="Jay MOULIN <jaymoulin@gmail.com> <http://twitter.com/moulinjay>"
LABEL version="${VERSION}"

ENV CHROME_DEBUG_PORT=9222

RUN apt-get update && \
    apt-get install -y wget unzip apt-transport-https ca-certificates curl gnupg chromium libgbm-dev --no-install-recommends --allow-unauthenticated && \
    wget -q -O chrome.zip https://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/${REVISION}/chrome-linux.zip && \
    unzip chrome.zip && \
    rm chrome.zip && \
    ln -sf ${PWD}/chrome-linux/chrome /usr/bin/chromium && \
    ln -sf /usr/bin/chromium /usr/bin/chromium-browser && \
    groupadd -r chrome && useradd -r -g chrome -G audio,video chrome && \
    mkdir -p /home/chrome/reports && \
    chown -R chrome:chrome /home/chrome &&\
    apt-get autoremove wget unzip -y

COPY entrypoint.sh /usr/bin/entrypoint

# Run Chrome non-privileged
USER chrome

# Drop to cli
ENTRYPOINT ["entrypoint"]
