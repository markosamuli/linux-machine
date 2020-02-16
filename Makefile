# Makefile for https://github.com/markosamuli/linux-machine
#
# Self-documented help from:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

.PHONY: default
default: help

.PHONY: help
help:  ## print this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup:  ## run setup with default options
	@./setup

.PHONY: clean
clean:  ## delete local development dependencies
	-rm -rf playbooks/roles/markosamuli.*
	-rm -rf playbooks/roles/zzet.rbenv
	@./scripts/delete_virtualenv.sh

# Get operating system name
UNAME_S := $(shell uname -s)

###
# Python, pyenv and virtualenv
###

PYENV_BIN = $(shell command -v pyenv 2>/dev/null)

.PHONY: setup-pyenv
setup-pyenv:
ifeq ($(PYENV_BIN),)
	@$(MAKE) python
endif

.PHONY: setup-pyenv-virtualenv
setup-pyenv-virtualenv: setup-pyenv
	@./scripts/create_virtualenv.sh

.PHONY: setup-requirements
setup-requirements: setup-pyenv-virtualenv
	@pip install -q -r requirements.txt

.PHONY: setup-dev-requirements
setup-dev-requirements: setup-pyenv-virtualenv
	@pip install -q -r requirements.dev.txt

###
# Homebrew
###

BREW_BIN = $(shell command -v brew 2>/dev/null)

.PHONY: setup-homebrew
setup-homebrew:
ifeq ($(BREW_BIN),)
ifeq ($(UNAME_S),Linux)
	@$(MAKE) linuxbrew
endif
ifeq ($(UNAME_S),Darwin)
	@./setup --no-install-ansible --no-run-playbook --no-install-roles
endif
endif

###
# pre-commit
###

PRE_COMMIT_INSTALLED = $(shell pre-commit --version 2>&1 | head -1 | grep -q 'pre-commit 1' && echo true)

.PHONY: setup-pre-commit
setup-pre-commit:
ifneq ($(PRE_COMMIT_INSTALLED),true)
	@$(MAKE) setup-dev-requirements
endif

###
# Go
###

GO_BIN = $(shell command -v go 2>/dev/null)

.PHONY: setup-golang
setup-golang:
ifeq ($(GO_BIN),)
	@$(MAKE) golang
endif

###
# shfmt
###

SHFMT_BIN = $(shell command -v shfmt 2>/dev/null)

.PHONY: setup-shfmt
setup-shfmt: setup-golang
ifeq ($(SHFMT_BIN),)
	GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
endif

###
# shellcheck
###

SHELLCHECK_BIN = $(shell command -v shellcheck 2>/dev/null)

.PHONY: setup-shellcheck
setup-shellcheck:
ifeq ($(SHELLCHECK_BIN),)
	@./setup -q -t shellcheck
endif

###
# pylint
###

PYLINT_INSTALLED = $(shell pylint --version 2>&1 | head -1 | grep -q 'pylint 2' && echo true)

.PHONY: setup-pylint
setup-pylint:
ifneq ($(PYLINT_INSTALLED),true)
	@$(MAKE) setup-dev-requirements
endif

###
# Linting and formatting
###

.PHONY: lint
lint: setup-pre-commit setup-shfmt setup-shellcheck setup-pylint  ## run pre-commit hooks on all files
	@pre-commit run -a

.PHONY: python-format
python-format: setup-pre-commit  ## format Python files
	@-pre-commit run -a requirements-txt-fixer
	@-pre-commit run -a yapf

.PHONY: python-lint
python-lint: setup-pre-commit setup-pylint python-format  ## lint and format Python files
	@pre-commit run -a check-ast
	@pre-commit run -a flake8
	@pre-commit run -a pylint

.PHONY: travis-lint
travis-lint: setup-pre-commit  ## lint .travis.yml file
	@pre-commit run -a travis-lint

###
# Ansible setup
###

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

###
# Playbooks
###

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
	@./scripts/configure.py install_docker true
	@./setup -q -t docker

.PHONY: editors
editors:  ## install IDEs and code editors
	@./setup -q -t editors

.PHONY: gcloud
gcloud: playbooks/roles/markosamuli.gcloud  ## install Google Cloud SDK
	@./scripts/configure.py install_gcloud true
	@./setup -q -t gcloud

.PHONY: linuxbrew
linuxbrew: playbooks/roles/markosamuli.linuxbrew  ## install Homebrew on Linux
ifeq ($(UNAME_S),Linux)
	@./scripts/configure.py install_linuxbrew true
	@./setup -q -t linuxbrew
else
	$(error "operating system $(UNAME_S) not supported")
endif

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
ruby: playbooks/roles/zzet.rbenv  ## install Ruby with rbenv
	@./scripts/configure.py install_ruby true
	@./setup -q -t ruby,rbenv

.PHONY: rust
rust: playbooks/roles/markosamuli.rust  ## install Rust programming language
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

###
# Ansible roles
###

playbooks/roles/zzet.rbenv:
	@./setup --no-run-playbook

playbooks/roles/markosamuli.%:
	@./setup --no-run-playbook

###
# Git hooks
###

PRE_COMMIT_HOOKS = .git/hooks/pre-commit
PRE_PUSH_HOOKS = .git/hooks/pre-push
COMMIT_MSG_HOOKS = .git/hooks/commit-msg
GIT_HOOKS = $(PRE_COMMIT_HOOKS) $(PRE_PUSH_HOOKS) $(COMMIT_MSG_HOOKS)

.PHONY: install-git-hooks
install-git-hooks: $(GIT_HOOKS) ## install Git hooks

$(PRE_COMMIT_HOOKS): setup-pre-commit
	@pre-commit install --install-hooks

$(PRE_PUSH_HOOKS): setup-pre-commit
	@pre-commit install --install-hooks -t pre-push

$(COMMIT_MSG_HOOKS): setup-pre-commit
	@pre-commit install --install-hooks -t commit-msg
