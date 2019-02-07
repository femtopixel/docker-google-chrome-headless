VERSION ?= 72.0.3626.96
CACHE ?= --no-cache=1
FULLVERSION ?= 72.0.3626.96
archs = amd64 i386
.PHONY: all build publish latest version
all: build publish
build:
	cp /usr/bin/qemu-*-static .
	$(foreach arch,$(archs), \
		cat Dockerfile | sed "s/FROM debian:sid-slim/FROM $(arch)\/debian:sid-slim/g" > .build; \
		docker build -t femtopixel/google-chrome-headless:${VERSION}-$(arch) -f .build --build-arg VERSION=${VERSION}-$(arch) ${CACHE} .;\
	)
publish:
	docker push femtopixel/google-chrome-headless
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}/g" > manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$FULLVERSION/latest/g" > manifest.yaml
	manifest-tool push from-spec manifest.yaml
