package format

import "github.com/clanky1024/renovate-gomodtidyall-graph-issue/service/model"

func DisplayName(descriptor model.Descriptor) string {
	return descriptor.Name
}
