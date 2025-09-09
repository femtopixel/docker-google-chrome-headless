VERSION ?= 142.0.7393.7
CACHE ?= --no-cache=1
REVISION ?= 1512833
archs = amd64 i386

.PHONY: all build publish
all: build publish
build:
	docker buildx build --platform linux/i386,linux/amd64 ${PUSH} --build-arg VERSION=${VERSION} --build-arg REVISION=${REVISION} --tag femtopixel/google-chrome-headless --tag femtopixel/google-chrome-headless:${VERSION} ${CACHE} .
publish:
	PUSH=--push CACHE= make build
