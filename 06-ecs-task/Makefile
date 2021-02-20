################################################################################
# 変数
################################################################################
PROJECT_ENV         := ${PROJECT_ENV}
PROJECT_NAME        := ${PROJECT_NAME}
STACK_NAME          := $(PROJECT_NAME)-ecs-task-$(PROJECT_ENV)
CONTAINER_IMAGE_TAG := 3912719----20210220T1145_0900

################################################################################
# タスク
################################################################################
.PHONY: create
create: # CFnのスタック作成
	aws cloudformation create-stack --stack-name $(STACK_NAME) --template-body file://./main.yaml --parameters ParameterKey=ProjectName,ParameterValue=$(PROJECT_NAME) ParameterKey=Environment,ParameterValue=$(PROJECT_ENV) ParameterKey=ContainerImageTag,ParameterValue=$(CONTAINER_IMAGE_TAG)

.PHONY: update
update: # CFnのスタック更新
	aws cloudformation update-stack --stack-name $(STACK_NAME) --template-body file://./main.yaml --parameters ParameterKey=ProjectName,ParameterValue=$(PROJECT_NAME) ParameterKey=Environment,ParameterValue=$(PROJECT_ENV) ParameterKey=ContainerImageTag,ParameterValue=$(CONTAINER_IMAGE_TAG)

.PHONY: delete
delete: # CFnのスタック削除
	aws cloudformation delete-stack --stack-name $(STACK_NAME)

.PHONY: list-parameter-store
list-parameter-store: # CFnで作ったParameterStore一覧
	aws ssm get-parameters-by-path --path "/$(PROJECT_NAME)/$(PROJECT_ENV)/" | jq -rc '.Parameters | sort_by(.Name) | .[] | {name: .Name, value: .Value}'
