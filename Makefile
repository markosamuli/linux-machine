# Makefile for https://github.com/markosamuli/linux-machine
#
# Self-documented help from:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

# Get paths to required commands


.PHONY: default
default: help

.PHONY: help
help:  ## print this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup:  ## run setup with default options
	@./setup

# Get paths to pyenv and Python commmands
PYENV_BIN = $(shell command -v pyenv 2>/dev/null)
PYTHON_BIN = $(shell command -v python 2>/dev/null)

# Configure pyenv variables only if pyenv is found
ifneq ($(PYENV_BIN),)
# Python version to use for the virtualenv
PYTHON_VERSION = $(shell pyenv install --list | sed 's/ //g' | grep "^3\.7\.[0-9]*$$" | sort -r | head -1)
PYTHON_VERSION_PATH = $(HOME)/.pyenv/versions/$(PYTHON_VERSION)

# Virtualenv name will be generated from the repository name
PYENV_VIRTUALENV = $(shell basename "$(shell pwd)")
PYENV_VIRTUALENV_PATH = $(HOME)/.pyenv/versions/$(PYENV_VIRTUALENV)

# Get local pyenv version
PYENV_LOCAL = $(shell pyenv local 2>/dev/null)
endif

.PHONY: setup-pyenv-virtualenv
setup-pyenv-virtualenv:  ## setup virtualenv with pyenv for development
ifeq ($(PYENV_BIN),)
	@echo "pyenv is not installed"
	@exit 1
endif
ifeq ($(PYENV_LOCAL),)
# Local version is not defined
# 1. Install Python if missing
# 2. Create virtualenv if missing
# 3. Set local virtualenv
ifeq (,$(wildcard $(PYTHON_VERSION_PATH)))
	@echo "Install Python $(PYTHON_VERSION)"
	@pyenv install $(PYTHON_VERSION)
endif
ifeq (,$(wildcard $(PYENV_VIRTUALENV_PATH)))
	@echo "Creating virtualenv '$(PYENV_VIRTUALENV)' with pyenv using Python $(PYTHON_VERSION)"
	@pyenv virtualenv $(PYTHON_VERSION) $(PYENV_VIRTUALENV)
endif
	@echo "Using existing virtualenv '$(PYENV_VIRTUALENV)'"
	@pyenv local $(PYENV_VIRTUALENV)
else
# Local version is set
ifneq ($(PYENV_LOCAL),$(PYENV_VIRTUALENV))
	@echo "WARNING: pyenv local version should be $(PYENV_VIRTUALENV), found $(PYENV_LOCAL)"
endif
endif

.PHONY: setup-requirements
setup-requirements: setup-pyenv-virtualenv  ## setup requirements for running the scripts
	@pip install -q -r requirements.txt

.PHONY: setup-dev-requirements
setup-dev-requirements: setup-pyenv-virtualenv  ## setup development requirements
	@pip install -q -r requirements.dev.txt

PRE_COMMIT_INSTALLED = $(shell pre-commit --version 2>&1 | head -1 | grep -q 'pre-commit 1' && echo true)

.PHONY: setup-pre-commit
setup-pre-commit:
ifneq ($(PRE_COMMIT_INSTALLED),true)
	@$(MAKE) setup-dev-requirements
endif

SHFMT = $(shell command -v shfmt 2>/dev/null)
GO_BIN = $(shell command -v go 2>/dev/null)

.PHONY: setup-shfmt
setup-shfmt:
ifeq ($(SHFMT),)
ifeq ($(GO_BIN),)
	$(error "go not found, failed to install shfmt")
else
	GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
endif
endif

SHELLCHECK = $(shell command -v shellcheck 2>/dev/null)
SNAP = $(shell command -v snap 2>/dev/null)

.PHONY: setup-shellcheck
setup-shellcheck:
ifeq ($(SHELLCHECK),)
ifeq ($(SNAP),)
	$(error "snap not found, failed to install shellcheck")
else
	snap install shellcheck
endif
endif

.PHONY: lint
lint: setup-pre-commit setup-shfmt setup-shellcheck  ## run pre-commit hooks on all files
	@pre-commit run -a

.PHONY: python-format
python-format: setup-pre-commit  ## format Python files
	@-pre-commit run -a requirements-txt-fixer
	@-pre-commit run -a yapf

.PHONY: python-lint
python-lint: setup-pre-commit setup-dev-requirements python-format  ## lint and format Python files
	@pre-commit run -a check-ast
	@pre-commit run -a flake8
	@pre-commit run -a pylint

.PHONY: travis-lint
travis-lint: setup-pre-commit  ## lint .travis.yml file
	@pre-commit run -a travis-lint

.PHONY: setup-ansible
install-ansible:  ## install Ansible without roles or running playbooks
	@./setup \
		--install-ansible \
		--no-run-playbook \
		--no-install-roles \
		--print-versions \
		--verbose

.PHONY: install-roles
install-roles:  ## install Ansible roles
	@./setup --no-run-playbook

.PHONY: list-tags
list-tags:  # list Ansible tags
	@./setup --no-run-playbook --no-install-roles -l

.PHONY: clean-roles
clean-roles: setup-requirements  ## remove outdated Ansible roles
	@./scripts/clean_roles.py

.PHONY: update-roles
update-roles: setup-requirements  ## update Ansible roles in the requirements.yml file
	@./scripts/update_roles.py

.PHONY: latest-roles
latest-roles: update-roles clean-roles install-roles  # update Ansible roles and install new versions

.PHONY: antivirus
antivirus: ## install antivirus software
	@./scripts/configure.py install_antivirus true
	@./setup -q -t antivirus

.PHONY: audit
audit: security  ## audit system with Lynis
	sudo lynis audit system

.PHONY: aws
aws: playbooks/roles/markosamuli.aws_tools  ## install AWS tools
	@./scripts/configure.py install_aws true
	@./setup -q -t aws

.PHONY: docker
docker:  ## install Docker
	@./setup -q -t docker

.PHONY: editors
editors:  ## install IDEs and code editors
	@./setup -q -t editors

.PHONY: gcloud
gcloud: playbooks/roles/markosamuli.gcloud  ## install Google Cloud SDK
	@./setup -q -t gcloud

.PHONY: linuxbrew
linuxbrew: playbooks/roles/markosamuli.linuxbrew  ## install Homebrew on Linux
	@./scripts/configure.py install_linuxbrew true
	@./setup -q -t linuxbrew

.PHONY: golang
golang: playbooks/roles/markosamuli.golang  ## install Go programming language
	@./scripts/configure.py install_golang true
	@./setup -q -t golang

.PHONY: lua
lua: ## install Lua programming language
	@./scripts/configure.py install_lua true
	@./setup -q -t lua

.PHONY: monitoring
monitoring: ## install monitoring tools
	@./scripts/configure.py install_monitoring true
	@./setup -q -t monitoring

.PHONY: node
node: playbooks/roles/markosamuli.nvm  ## install Node.js with NVM
	@./scripts/configure.py install_nodejs true
	@./setup -q -t node,nvm

.PHONY: permissions
permissions:  ## fix permissions in user home directory
	@USER_HOME_FIX_PERMISSIONS=true ./setup -q -t permissions

.PHONY: productivity
productivity:  ## install productivity tools
	@./scripts/configure.py install_productivity true
	@./setup -q -t productivity

.PHONY: python
python: playbooks/roles/markosamuli.pyenv  ## install Python with pyenv
	@./scripts/configure.py install_python true
	@./setup -q -t python,pyenv

.PHONY: ruby
ruby: playbooks/roles/zzet.rbenv  # install Ruby with rbenv
	@./scripts/configure.py install_ruby true
	@./setup -q -t ruby,rbenv

.PHONY: rust
rust: playbooks/roles/markosamuli.rust  ## install Rust
	@./scripts/configure.py install_rust true
	@./setup -q -t rust

.PHONY: security
security: ## install security tools
	@./scripts/configure.py install_security true
	@./setup -q -t security

.PHONY: security-hardening
security-hardening: ## install security hardening software
	@./scripts/configure.py install_security_hardening true
	@./setup -q -t security-hardening

.PHONY: shellcheck
shellcheck: ## install shellcheck
	@./setup -q -t shellcheck

.PHONY: terraform
terraform: playbooks/roles/markosamuli.terraform  ## install Terraform
	@./scripts/configure.py install_terraform true
	@./setup -q -t terraform

.PHONY: tools
tools:  ## install tools
	@./setup -q -t tools

.PHONY: zsh
zsh:  ## install zsh
	@./scripts/configure.py install_zsh true
	@./setup -q -t zsh

playbooks/roles/zzet.rbenv:
	@./setup --no-run-playbook

playbooks/roles/markosamuli.%:
	@./setup --no-run-playbook

PRE_COMMIT_HOOKS = .git/hooks/pre-commit
PRE_PUSH_HOOKS = .git/hooks/pre-push
COMMIT_MSG_HOOKS = .git/hooks/commit-msg

.PHONY: install-git-hooks
install-git-hooks: $(PRE_COMMIT_HOOKS) $(PRE_PUSH_HOOKS) $(COMMIT_MSG_HOOKS)  ## install Git hooks

$(PRE_COMMIT_HOOKS): setup-pre-commit
	@pre-commit install --install-hooks

$(PRE_PUSH_HOOKS): setup-pre-commit
	@pre-commit install --install-hooks -t pre-push

$(COMMIT_MSG_HOOKS): setup-pre-commit
	@pre-commit install --install-hooks -t commit-msg
