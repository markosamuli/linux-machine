PRE_COMMIT_HOOKS=.git/hooks/pre-commit
VENV=.venv

.PHONY: update
update: $(VENV)
	@(. $(VENV)/bin/activate && ./update-roles)

.PHONY: lint
lint: $(PRE_COMMIT_HOOKS)
	@pre-commit run -a

$(VENV):
	@virtualenv $(VENV)
	@(. $(VENV)/bin/activate && pip install -r requirements.txt)

$(PRE_COMMIT_HOOKS):
	@pre-commit install
