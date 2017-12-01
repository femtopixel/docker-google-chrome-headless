VERSION ?= 0.2.0
CACHE ?= --no-cache=1
FULLVERSION ?= ${VERSION}
archs = arm32v7 amd64 i386
.PHONY: all build publish latest version
all: build publish
build:
	cp /usr/bin/qemu-*-static .
	$(foreach arch,$(archs), \
		cat Dockerfile | sed "s/FROM debian:stable-slim/FROM $(arch)\/debian:stable-slim/g" > .build; \
		if [ $(arch) = arm32v7 ]; then \
		docker build -t femtopixel/google-chrome-headless:${VERSION}-$(arch) -f .build --build-arg ISARM=1 ${CACHE} .;\
		else docker build -t femtopixel/google-chrome-headless:${VERSION}-$(arch) -f .build --build-arg ISARM=0 ${CACHE} .;\
		fi;\
	)
publish:
	docker push femtopixel/google-chrome-headless
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}-debian/g" > manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$FULLVERSION/latest/g" > manifest.yaml
	manifest-tool push from-spec manifest.yaml
