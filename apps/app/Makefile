################################################################################
# 変数
################################################################################
PROJECT_NAME    := ${PROJECT_NAME}
REPOSITORY_NAME := $(PROJECT_NAME)

################################################################################
# マクロ
################################################################################

################################################################################
# タスク
################################################################################
.PHONY: docker-build
docker-build:
	docker build ./ --tag $(REPOSITORY_NAME):latest

.PHONY: ci
ci:
	$(eval AWS_REGION_NAME := ap-northeast-1)
	$(eval IMAGE_TAG := $(shell git rev-parse --short HEAD))
	$(eval AWS_ACCOUNT_ID := $(shell aws sts get-caller-identity --query 'Account' --output text))
	$(eval REPOSITORY_URI := $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION_NAME).amazonaws.com/$(REPOSITORY_NAME))
	$(eval TEMP_TIME := $(shell TZ=Asia/Tokyo && date +"%Y%m%dT%H%M_0900"))
	@aws ecr get-login-password --region $(AWS_REGION_NAME) | docker login --username AWS --password-stdin $(REPOSITORY_URI)
	docker build ./ --tag $(REPOSITORY_NAME):latest
	docker image tag $(REPOSITORY_NAME):latest $(REPOSITORY_URI):$(IMAGE_TAG)----$(TEMP_TIME)
	docker push $(REPOSITORY_URI):$(IMAGE_TAG)----$(TEMP_TIME)
	docker image rm $(REPOSITORY_URI):$(IMAGE_TAG)----$(TEMP_TIME)
