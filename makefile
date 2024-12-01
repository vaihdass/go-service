# Naming
VERSION := 1.0

KIND_CLUSTER_NAME := vaihdass-cluster

# Define dependencies
KIND_IMAGE := kindest/node:v1.26.15

ifeq ($(OS),Windows_NT)
	CURR_DATE_CMD := $(shell powershell -Command "Get-Date -Format 'yyyy-MM-ddTHH:mm:ssZ'")
else
    CURR_DATE_CMD := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
endif

all: service

clean:
	go clean

run:
	go run main.go

build:
	go build -ldflags "-X main.build=local" main.go

service:
	docker build \
		-f build/package/docker/Dockerfile \
		-t service-amd64:$(VERSION) \
		--build-arg BUILD_REF=$(VERSION) \
		--build-arg BUILD_DATE=$(CURR_DATE_CMD) \
		.

dev-up:
	kind create cluster \
		--image $(KIND_IMAGE) \
		--name $(KIND_CLUSTER_NAME) \
		--config build/package/k8s/kind/kind-config.yaml

dev-status:
	kubectl get nodes -o wide
	kubectl get svc -o wide

dev-down:
	kind delete cluster --name $(KIND_CLUSTER_NAME)
