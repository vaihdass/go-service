run:
	go run main.go

build:
	go build -ldflags "-X main.build=local" main.go

clean:
	go clean
