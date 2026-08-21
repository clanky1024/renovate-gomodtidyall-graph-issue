package service

import "github.com/clanky1024/renovate-gomodtidyall-graph-issue/tooling"

type Config struct {
	Message string `yaml:"message"`
}

func ParseConfig(input []byte) (Config, error) {
	var config Config
	err := tooling.ParseYAML(input, &config)
	return config, err
}
