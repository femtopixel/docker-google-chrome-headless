FROM debian:stable-slim as builder

ADD qemu-*-static /usr/bin/

FROM builder

LABEL maintainer="Jay MOULIN <jaymoulin@gmail.com> <http://twitter.com/moulinjay>"

ENV CHROME_DEBUG_PORT=9222
ARG ISARM=0

RUN if [ ${ISARM:-0} = 1 ]; then echo "\
    deb http://ports.ubuntu.com/ trusty main restricted universe multiverse \
    deb http://ports.ubuntu.com/ trusty-updates main restricted universe multiverse \
    deb http://ports.ubuntu.com/ trusty-security main restricted universe multiverse \
    " >> /etc/apt/sources.list; else echo "\
    deb http://archive.ubuntu.com/ubuntu/ bionic main restricted \
    deb http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted \
    deb http://archive.ubuntu.com/ubuntu/ bionic universe \
    deb-src http://archive.ubuntu.com/ubuntu/ bionic universe \
    deb http://archive.ubuntu.com/ubuntu/ bionic-updates universe \
    deb-src http://archive.ubuntu.com/ubuntu/ bionic-updates universe \
    deb http://archive.ubuntu.com/ubuntu/ bionic multiverse \
    deb http://archive.ubuntu.com/ubuntu/ bionic-updates multiverse \
    deb http://archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse \
    deb http://security.ubuntu.com/ubuntu/ bionic-security main restricted \
    deb http://security.ubuntu.com/ubuntu/ bionic-security universe \
    deb-src http://security.ubuntu.com/ubuntu/ bionic-security universe \
    deb http://security.ubuntu.com/ubuntu/ bionic-security multiverse \
    " >> /etc/apt/sources.list; fi && \
    apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg chromium-browser --no-install-recommends --allow-unauthenticated && \
    groupadd -r chrome && useradd -r -g chrome -G audio,video chrome && \
    mkdir -p /home/chrome/reports && chown -R chrome:chrome /home/chrome

COPY entrypoint.sh /usr/bin/entrypoint

# Run Chrome non-privileged
USER chrome

# Drop to cli
ENTRYPOINT ["entrypoint"]
