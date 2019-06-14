# import config.
# You can change the default config with `make cnf="config_special.env" build`
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# import deploy config
# You can change the default deploy config with `make cnf="deploy_special.env" release`
dpl ?= deploy.env
include $(dpl)
export $(shell sed 's/=.*//' $(dpl))

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
# Build the container
build: ## Build the container
	docker build -t $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION) .

run: ## Run container on port configured in `config.env`
	docker run -it --rm -p=$(LOCAL_PORT):$(RACK_PORT) --name="$(IMAGE_NAME)" $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION)

rund: ## Run container detached on port configured in `config.env`
	docker run -itd -p=$(LOCAL_PORT):$(RACK_PORT) --name="$(IMAGE_NAME)" $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION)

runi: ## Run container on interactive mode on port configured in `config.env`
	docker run -it --rm -p=$(LOCAL_PORT):$(RACK_PORT) --name="$(IMAGE_NAME)" $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION) /bin/bash

stop: ## Stop and remove a running container
	docker stop $(IMAGE_NAME); docker rm $(IMAGE_NAME)

publish-latest: tag-latest ## Publish the `latest` taged container to Docker Hub
	@echo 'publish latest to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/$(IMAGE_NAME):latest

publish-version: tag-version ## Publish the `{version}` taged container to ECR
	@echo 'publish $(VERSION) to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION)

tag-latest: ## Generate container `{version}` tag
	@echo 'create tag latest'
	docker tag $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION) $(DOCKER_REPO)/$(IMAGE_NAME):latest

tag-version: ## Generate container `latest` tag
	@echo 'create tag $(VERSION)'
	docker tag $(DOCKER_REPO)/$(IMAGE_NAME) $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION)

# Build the container
compose-up: ## Build the release and develoment container. The development
	docker-compose up

version: ## Output the current version
	@echo $(VERSION)
