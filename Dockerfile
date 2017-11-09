FROM bitnami/minideb

MAINTAINER Jay MOULIN <jaymoulin@gmail.com> <http://twitter.com/moulinjay>

ENV CHROME_DEBUG_PORT=9222

# Install deps + add Chrome Stable + purge all the things
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg --no-install-recommends && \
  curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -  && \
  echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list  && \
  apt-get update && apt-get install -y google-chrome-stable --no-install-recommends && \
  apt-get purge --auto-remove -y curl gnupg && \
  rm -rf /var/lib/apt/lists/* && \
  groupadd -r chrome && useradd -r -g chrome -G audio,video chrome && \
  mkdir -p /home/chrome/reports && chown -R chrome:chrome /home/chrome

COPY entrypoint.sh /usr/bin/entrypoint

# Run Chrome non-privileged
USER chrome

# Drop to cli
ENTRYPOINT ["entrypoint"]
