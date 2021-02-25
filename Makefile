VERSION ?= 90.0.4427.5
CACHE ?= --no-cache=1
FULLVERSION ?= 90.0.4427.5
REVISION ?= 857879
archs = amd64 i386
.PHONY: all build publish latest version
all: build publish
build:
	cp -R /usr/bin/qemu-*-static .
	$(foreach arch,$(archs), \
		cat Dockerfile | sed "s/FROM debian:stable-slim/FROM $(arch)\/debian:stable-slim/g" > .build; \
		docker build -t femtopixel/google-chrome-headless:${VERSION}-$(arch) -f .build --build-arg VERSION=${VERSION}-$(arch) --build-arg REVISION=${REVISION} ${CACHE} .;\
	)
publish:
	docker push femtopixel/google-chrome-headless -a
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}/g" > manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$FULLVERSION/latest/g" > manifest.yaml
	manifest-tool push from-spec manifest.yaml
