.PHONY: lint travis-lint pre-commit install-git-hooks

PRE_COMMIT := $(shell command -v pre-commit 2> /dev/null)
TRAVIS := $(shell command -v travis 2> /dev/null)

PRE_COMMIT_HOOKS = .git/hooks/pre-commit
PRE_PUSH_HOOKS = .git/hooks/pre-push
COMMIT_MSG_HOOKS = .git/hooks/commit-msg

lint: pre-commit travis-lint

pre-commit: install-git-hooks
ifndef PRE_COMMIT
	$(error "pre-commit not found, try: 'pip install pre-commit'")
else
	@pre-commit run -a
endif

travis-lint:
ifndef TRAVIS
	$(error "travis CLI not found, try: 'gem install travis'")
else
	@travis lint
endif

install-git-hooks: $(PRE_COMMIT_HOOKS) $(PRE_PUSH_HOOKS) $(COMMIT_MSG_HOOKS)

$(PRE_COMMIT_HOOKS):
	@pre-commit install --install-hooks

$(PRE_PUSH_HOOKS):
	@pre-commit install --install-hooks -t pre-push

$(COMMIT_MSG_HOOKS):
	@pre-commit install --install-hooks -t commit-msg
