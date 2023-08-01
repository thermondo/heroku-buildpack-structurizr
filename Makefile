lint: shellcheck hadolint
.PHONY: lint

shellcheck:
	shellcheck bin/*
.PHONY: shellcheck

hadolint:
	hadolint Dockerfile
.PHONY: hadolint
