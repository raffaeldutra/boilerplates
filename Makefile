.DEFAULT_GOAL := help

# How many spaces do you want to create CLI output for yous commands when typed the `make` command.
# To change on CLI at runtime, use: make SPACES=20
SPACES ?= 10

# Color values
RED     := 31m
GREEN   := 32m
YELLOW  := 33m
BLUE    := 34m
MAGENTA := 35m
CYAN    := 36m
WHITE   := 37m

# Change the color output for help menu
HELP_COMMAND_COLOR = $(RED)

# Default tag

IMAGE_DEFAULT_TAG ?= 1.0

# Default BASH theme for oh-my-bash
OSH_THEME ?= kitsune

platform       ?= linux/amd64
imagebase      = raffaeldutra/boilerplate-base:$(IMAGE_DEFAULT_TAG)
imageAnsible   = raffaeldutra/boilerplate-ansible:$(IMAGE_DEFAULT_TAG)
imageTerraform = raffaeldutra/boilerplate-terraform:$(IMAGE_DEFAULT_TAG)
imagePacker    = raffaeldutra/boilerplate-packer:$(IMAGE_DEFAULT_TAG)


.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[$(HELP_COMMAND_COLOR)%-$(SPACES)s\033[0m %s\n", $$1, $$2}'


.PHONY: base
base: ## Build base image
	docker image build \
	--file Dockerfile.base \
	--tag $(imageBase) .


.PHONY: run-ansible
run-ansible: ## Run ansible container
	@echo "usage: make run-ansible"

	docker container run \
	--platform $(platform) \
	--interactive \
	--tty \
	--hostname ansible \
	--workdir /root/ansible \
	--env OSH_THEME=$(OSH_THEME) \
	--volume ./ansible/config/.bashrc:/root/.bashrc \
	$(imageAnsible)


.PHONY: build-ansible
build-ansible: ## Build Ansible image
	docker image build \
	--file ansible/Dockerfile \
	--tag $(imageAnsible) .


.PHONY: run-terraform
run-terraform: ## Run ansible container
	@echo "usage: make run-terraform"

	docker container run \
	--platform $(platform) \
	--interactive \
	--tty \
	--hostname terraform \
	--workdir /root/terraform \
	--env OSH_THEME=$(OSH_THEME) \
	--volume ./terraform/config/.bashrc:/root/.bashrc \
	$(imageTerraform)


.PHONY: build-terraform
build-terraform: ## Build Terraform image
	docker image build \
	--file terraform/Dockerfile \
	--tag $(imageTerraform) .


.PHONY: run-packer
run-packer: ## Run Packer container
	@echo "usage: make run-packer"
# The host networking driver only works on Linux hosts, and is not supported on Docker Desktop for Mac,
# Docker Desktop for Windows, or Docker EE for Windows Server.

	docker container run \
	--platform $(platform) \
	--interactive \
	--tty \
	--hostname packer \
	--workdir /root/packer \
	--env OSH_THEME=$(OSH_THEME) \
	--volume ./packer/config/.bashrc:/root/.bashrc \
	$(imagePacker)


.PHONY: build-packer
build-packer: ## Build Packer image
	docker image build \
	--file packer/Dockerfile \
	--tag $(imagePacker) .


.PHONY: run-observability
run-observability: ## Run observability stack

	docker compose \
	-f observability/docker-compose.yml \
	up


.PHONY: down-observability
down-observability: ## Down	observability stack

	docker compose \
	-f observability/docker-compose.yml \
	down


# Tests
run-packer-test: ## Run Packer container test
	@echo "usage: make run-packer-test"

	docker container run \
	--platform $(platform) \
 	--rm \
	--entrypoint packer \
	$(imagePacker) \
	version


.PHONY: run-terraform-test
run-terraform-test: ## Run Packer container test
	@echo "usage: make run-terraform-test"

	docker container run \
	--platform $(platform) \
 	--rm \
	--entrypoint terraform \
	$(imageTerraform) \
	version


.PHONY: run-ansible-test
run-ansible-test: ## Run Ansible container test
	@echo "usage: make run-ansible-test"

	docker container run \
	--platform $(platform) \
 	--rm \
	--entrypoint ansible \
	$(imageAnsible) \
	--version
