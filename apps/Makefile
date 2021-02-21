################################################################################
# タスク
################################################################################
.PHONY: build
build:
	cd app && make docker-build
	cd nginx-sidecar && make docker-build

.PHONY: ci
ci:
	cd app && make ci
	cd nginx-sidecar && make ci
