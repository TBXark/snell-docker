DOCKER_IMAGE := ghcr.io/tbxark/snell-server
DOCKER_FILE := Dockerfile

.PHONY: build
build:
	docker buildx build --platform=linux/amd64,linux/arm64 -t $(DOCKER_IMAGE) . -f $(DOCKER_FILE) --push --provenance=false