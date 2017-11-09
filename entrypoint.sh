#!/bin/bash
set -e

# first arg is `http` or `--some-option`
if [[ "http*" == "$1" ]] || [[ "-*" == "$1" ]] || [[ "about:blank" == "$1" ]] || [[ "$#" == 0 ]]; then
    set -- google-chrome --headless --disable-gpu --remote-debugging-address=0.0.0.0 --remote-debugging-port=$CHROME_DEBUG_PORT "$@"
fi
exec "$@"

