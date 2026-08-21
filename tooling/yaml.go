package tooling

import "go.yaml.in/yaml/v3"

func ParseYAML(input []byte, output any) error {
	return yaml.Unmarshal(input, output)
}
