GIT_VERSION = $(shell git describe --always --abbrev=7 --dirty)

BASE_IMAGE_NAME        = hello-osiris

ifdef DOCKER_REGISTRY
	DOCKER_REGISTRY := $(DOCKER_REGISTRY)/
endif

ifdef DOCKER_REGISTRY_NAMESPACE
	DOCKER_REGISTRY_NAMESPACE := $(DOCKER_REGISTRY_NAMESPACE)/
endif

RC_IMAGE_NAME          := $(DOCKER_REGISTRY)$(DOCKER_REGISTRY_NAMESPACE)$(BASE_IMAGE_NAME):$(GIT_VERSION)
RC_MUTABLE_IMAGE_NAME  := $(DOCKER_REGISTRY)$(DOCKER_REGISTRY_NAMESPACE)$(BASE_IMAGE_NAME):edge

REL_IMAGE_NAME         := $(DOCKER_REGISTRY)$(DOCKER_REGISTRY_NAMESPACE)$(BASE_IMAGE_NAME):$(REL_VERSION)
REL_MUTABLE_IMAGE_NAME := $(DOCKER_REGISTRY)$(DOCKER_REGISTRY_NAMESPACE)$(BASE_IMAGE_NAME):latest

# Build the Docker image
.PHONY: build
build:
	docker build -t $(RC_IMAGE_NAME) .
	docker tag $(RC_IMAGE_NAME) $(RC_MUTABLE_IMAGE_NAME)

# Push the release candidate Docker images
.PHONY: push-rc
push-rc: build
	docker push $(RC_IMAGE_NAME)
	docker push $(RC_MUTABLE_IMAGE_NAME)

# Push the release / semver Docker images
.PHONY: push-release
push-release:
ifndef REL_VERSION
	$(error REL_VERSION is undefined)
endif
	docker pull $(RC_IMAGE_NAME)
	docker tag $(RC_IMAGE_NAME) $(REL_IMAGE_NAME)
	docker tag $(RC_IMAGE_NAME) $(REL_MUTABLE_IMAGE_NAME)
	docker push $(REL_IMAGE_NAME)
	docker push $(REL_MUTABLE_IMAGE_NAME)
