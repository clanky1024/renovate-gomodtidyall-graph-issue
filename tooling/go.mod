module github.com/clanky1024/renovate-gomodtidyall-graph-issue/tooling

go 1.24.0

require (
	github.com/clanky1024/renovate-gomodtidyall-graph-issue/service v0.0.0
	go.yaml.in/yaml/v3 v3.0.4
)

replace github.com/clanky1024/renovate-gomodtidyall-graph-issue/service => ../service
