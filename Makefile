
IMG ?= titanide/nginx:latest

DIST ?= alpine

all: docker-buildx

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk commands is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


build:  ## Build docker image with the manager.
	docker build --tag=registry.cn-shenzhen.aliyuncs.com/${IMG} --build-arg UID=1000 --build-arg GID=1000 stable/${DIST}

buildx:
	docker buildx build --platform linux/amd64,linux/arm64 --tag=${IMG} --build-arg UID=1000 --build-arg GID=1000 stable/${DIST} --push


