package main

import (
	"context"
	"log"
	"os/signal"
	"syscall"
)

var build = "develop"

func main() {
	log.Println("starting service", build)
	defer log.Println("service ended")

	ctx, _ := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	<-ctx.Done()

	log.Println("stopping service")
}
