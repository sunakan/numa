################################################################################
# 変数
################################################################################
SLS_REPOSITORY_NAME := suna-sls

################################################################################
# マクロ
################################################################################

################################################################################
# タスク
################################################################################
.PHONY: chown
chown:
	sudo chown -R ${USER}:${USER} ./

.PHONY: docker-build
docker-build:
	docker build ./ --tag $(SLS_REPOSITORY_NAME):latest

.PHONY: docker-bash
docker-bash:
	$(eval DOCKER_WORKING_DIR := $(shell docker run --rm -it $(SLS_REPOSITORY_NAME) pwd))
	$(eval DOCKER_USER_HOME := $(shell docker run --rm -it $(SLS_REPOSITORY_NAME) bash -c 'echo $${HOME}'))
	docker run --rm -it --mount type=bind,source=${PWD}/,target=$(DOCKER_WORKING_DIR)/ --mount type=bind,source=${HOME}/.aws/,target=$(DOCKER_USER_HOME)/.aws/ --env-file ${PWD}/.env $(SLS_REPOSITORY_NAME):latest bash
