VERSION ?= 101.0.4947.0
CACHE ?= --no-cache=1
FULLVERSION ?= 101.0.4947.0
REVISION ?= 982874
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
