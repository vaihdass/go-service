VERSION := 1.0

ifeq ($(OS),Windows_NT)
	CURR_DATE_CMD := $(shell powershell -Command "Get-Date -Format 'yyyy-MM-ddTHH:mm:ssZ'")
else
    CURR_DATE_CMD := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
endif

all: service

run:c
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

clean:
	go clean
