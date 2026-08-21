package main

import (
	"fmt"

	"github.com/clanky1024/renovate-gomodtidyall-graph-issue/service"
)

func main() {
	config, err := service.ParseConfig([]byte("message: hello\n"))
	if err != nil {
		panic(err)
	}

	fmt.Println(config.Message)
}
