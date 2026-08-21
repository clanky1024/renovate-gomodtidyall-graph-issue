module github.com/clanky1024/renovate-gomodtidyall-graph-issue/app

go 1.24.0

require github.com/clanky1024/renovate-gomodtidyall-graph-issue/service v0.0.0

require (
	github.com/clanky1024/renovate-gomodtidyall-graph-issue/tooling v0.0.0 // indirect
	go.yaml.in/yaml/v3 v3.0.4 // indirect
)

replace github.com/clanky1024/renovate-gomodtidyall-graph-issue/service => ../service

replace github.com/clanky1024/renovate-gomodtidyall-graph-issue/tooling => ../tooling
