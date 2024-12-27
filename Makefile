#vars
ITOP_IMAGETAG=3.2.0
ITOP_DOWNLOAD_URL=https://sourceforge.net/projects/itop/files/itop/${ITOP_IMAGETAG}-2/iTop-${ITOP_IMAGETAG}-2-14758.zip/download
ITOP_IMAGEFULLNAME=lacrif/itop:${ITOP_IMAGETAG}

.PHONY: help build push all

help:
	@echo "Makefile commands:"
	@echo "build"
	@echo "push"
	@echo "compose-up"
	@echo "compose-down"
	@echo "all"

.DEFAULT_GOAL := all

#################################
# Docker targets
#################################
clean: version-check
	@echo "+ $@"
	@docker rmi ${ITOP_IMAGEFULLNAME}  || true

build: clean
	@echo "+ $@"
	@docker build Dockerfiles/ubuntu \
	--tag ${ITOP_IMAGEFULLNAME} \
	--build-arg ITOP_VERSION="${ITOP_IMAGETAG}" \
	--build-arg ITOP_DOWNLOAD_URL="${ITOP_DOWNLOAD_URL}"

compose-up:
	@docker compose up -d 

compose-down:
	@docker compose down

push:
	@docker push ${ITOP_IMAGEFULLNAME}

version-check:
	@echo "+ $@"
	@if [ -z "${ITOP_IMAGETAG}" ]; then \
		echo "VERSION is not set" ; \
		false ; \
	else \
		echo "VERSION is ${ITOP_IMAGETAG}"; \
	fi

all: image push

