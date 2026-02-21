VERSION ?= 147.0.7695.0
CACHE ?= --no-cache=1
REVISION ?= 1588249
archs = amd64 i386

.PHONY: all build publish
all: build publish
build:
	docker buildx build --platform linux/i386,linux/amd64 ${PUSH} --build-arg VERSION=${VERSION} --build-arg REVISION=${REVISION} --tag femtopixel/google-chrome-headless --tag femtopixel/google-chrome-headless:${VERSION} ${CACHE} .
publish:
	PUSH=--push CACHE= make build
