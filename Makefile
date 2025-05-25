#vars
ITOP_IMAGETAG=3.2
ITOP_DOWNLOAD_URL=https://sourceforge.net/projects/itop/files/itop/3.2.1-1/iTop-3.2.1-1-16749.zip/download
ITOP_IMAGEFULLNAME=lacrif/itop:${ITOP_IMAGETAG}

.PHONY: help build compose-up compose-down clean all

help:
	@echo "Makefile commands:"
	@echo "build"
	@echo "compose-up"
	@echo "compose-down"
	@echo "clean"
	@echo "all: build compose-up"

.DEFAULT_GOAL := all

#################################
# Docker targets
#################################
clean: version-check
	@echo "+ $@"
	@docker rmi ${ITOP_IMAGEFULLNAME}  || true

build: clean
	@echo "+ $@"
	@docker build . \
	--tag ${ITOP_IMAGEFULLNAME} \
	--build-arg ITOP_VERSION="${ITOP_IMAGETAG}" \
	--build-arg ITOP_DOWNLOAD_URL="${ITOP_DOWNLOAD_URL}"

compose-up:
	@docker compose up -d 

compose-down:
	@docker compose down

version-check:
	@echo "+ $@"
	@if [ -z "${ITOP_IMAGETAG}" ]; then \
		echo "VERSION is not set" ; \
		false ; \
	else \
		echo "VERSION is ${ITOP_IMAGETAG}"; \
	fi

all: build compose-up

