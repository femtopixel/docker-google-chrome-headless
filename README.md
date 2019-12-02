![logo](logo.png)

Google Chrome Headless - Docker Image
================================

[![latest release](https://img.shields.io/github/release/femtopixel/docker-google-chrome-headless.svg "latest release")](http://github.com/femtopixel/docker-google-chrome-headless/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/femtopixel/google-chrome-headless.svg)](https://hub.docker.com/r/femtopixel/google-chrome-headless/)
[![Docker Stars](https://img.shields.io/docker/stars/femtopixel/google-chrome-headless.svg)](https://hub.docker.com/r/femtopixel/google-chrome-headless/)
[![Bitcoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/btc.png "Bitcoin donation")](https://m.freewallet.org/id/374ad82e/btc)
[![Litecoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ltc.png "Litecoin donation")](https://m.freewallet.org/id/374ad82e/ltc)
[![Watch Ads](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/utip.png "Watch Ads")](https://utip.io/femtopixel)
[![PayPal donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ppl.png "PayPal donation")](https://www.paypal.me/jaymoulin)
[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png "Buy me a coffee")](https://www.buymeacoffee.com/3Yu8ajd7W)
[![Become a Patron](https://badgen.net/badge/become/a%20patron/F96854 "Become a Patron")](https://patreon.com/femtopixel)

[Google Chrome Headless](https://developers.google.com/web/updates/2017/04/headless-chrome) is the Google Chromium browser that can be started without graphical interface to accomplish several tasks (PDF printing, performance, automation...)

Usage
-----

```
docker run --rm --name chrome -it -p 9222:9222 femtopixel/google-chrome-headless <optional_args> <optional_site_url> 
```

With `<optional_site_url>` url to your site (e.g. http://www.google.com). By default `about:blank`. You can pass args **BEFORE** the `url` if you want to use some.

By default, Chrome Headless listen on the `9222` port but this can be changed by passing the `CHROME_DEBUG_PORT` environment to the value you want.

### Example

```
docker run --rm --name chrome -it -p 9000:9000 -e CHROME_DEBUG_PORT=9000 femtopixel/google-chrome-headless <optional_args> <optional_site_url> 
``` 
