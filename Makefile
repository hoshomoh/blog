UID ?= $(shell id -u)
GID ?= $(shell id -g)

help:
	@echo "\e[32m Usage make [target] "
	@echo
	@echo "\e[1m targets:"
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

clean: ## Clean everything
clean: clean-docker
.PHONY: clean

clean-docker: ## Remove images, volumes, containers
	# just in case, remove the volumes and the rest
	docker system prune -f --volumes --filter "label=application_name=personal-website" || true
	# remove all the related images and their deps
	docker image prune -f -a --filter "label=application_name=personal-website" || true
.PHONY: clean-docker

install: ## Install all application dependencies
install: install-app
.PHONY: install

install-app: ## Install the container(s) for the application
	# Hint: force a rebuild by passing --no-cache
	@UID=$(UID) GID=$(GID) docker-compose build --no-cache website
.PHONY: install-web

build: ## Build the web container
build: install-app
.PHONY: build

serve: ## Start the application
serve:
	# Start all containers
	@UID=$(UID) GID=$(GID) docker-compose up -d website

	#
	#  API URL: http://0.0.0.0:4000
	#
.PHONY: serve

shell: ## Start an interactive shell session (for web container)
	# Hint: adjust UID and GID to 0 if you want to use the shell as root
	@UID=$(UID) GID=$(GID) docker-compose run --rm -w /srv/jekyll -e SHELL_VERBOSITY=1 website bash
.PHONY: shell

watch-logs: ## Open a tail on all the logs
	@UID=$(UID) GID=$(GID) docker-compose logs -f -t
.PHONY: watch-logs

.DEFAULT_GOAL := help
