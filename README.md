![logo](logo.png)

Google Chrome Headless - Docker Image
================================

[![latest release](https://img.shields.io/github/release/femtopixel/docker-google-chrome-headless.svg "latest release")](http://github.com/femtopixel/docker-google-chrome-headless/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/femtopixel/google-chrome-headless.svg)](https://hub.docker.com/r/femtopixel/google-chrome-headless/)
[![Docker Stars](https://img.shields.io/docker/stars/femtopixel/google-chrome-headless.svg)](https://hub.docker.com/r/femtopixel/google-chrome-headless/)
[![PayPal donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ppl.png "PayPal donation")](https://www.paypal.me/jaymoulin)
[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png "Buy me a coffee")](https://www.buymeacoffee.com/jaymoulin)
[![Buy me a coffee](https://storage.ko-fi.com/cdn/kofi2.png "Buy me a coffee")](https://www.ko-fi.com/jaymoulin)

DISCLAIMER: As-of 2021, this product does not have a free support team anymore. If you want this product to be maintained, please support.

(This product is available under a free and permissive license, but needs financial support to sustain its continued improvements. In addition to maintenance and stability there are many desirable features yet to be added.)

THIS REPOSITORY IS AUTOUPDATED BY A BOT WHEN A NEW GOOGLE CHROME RELEASE IS UNLEASHED

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
