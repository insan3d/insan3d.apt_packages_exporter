.DEFAULT_GOAL := help

UV ?= uv
VENV := .venv

.PHONY: help requirements test-deps molecule clean

help: ## Show available commands
	@awk 'BEGIN { FS = ":.*## "; printf "Usage: make <target>\n\n" } /^[a-zA-Z0-9_.-]+:.*## / { printf "  %-18s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.venv:
	$(UV) venv --no-project --allow-existing --quiet

requirements-test.txt: requirements-test.in .python-version
	$(UV) pip compile --output-file $@ --no-header --quiet $<

requirements: ## Update and compile test dependencies
	$(UV) pip compile --output-file requirements-test.txt --no-header --upgrade --quiet requirements-test.in

test-deps: .venv requirements-test.txt ## Install test dependencies
	$(UV) pip install --python $(VENV)/bin/python --requirements requirements-test.txt --quiet
	ANSIBLE_HOME="$(abspath $(VENV))/.ansible" $(VENV)/bin/ansible-galaxy collection install -r molecule/requirements.yml

molecule: test-deps ## Test the role on Debian 13, including check mode and idempotence
	docker build --tag apt-packages-exporter-molecule-debian13:13 molecule
	ANSIBLE_HOME="$(abspath $(VENV))/.ansible" PATH="$(abspath $(VENV))/bin:$$PATH" $(VENV)/bin/molecule test

clean: ## Remove generated test dependencies
	rm -rf "$(VENV)"
	rm -f requirements-test.txt
