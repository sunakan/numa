################################################################################
# 変数
################################################################################
PROJECT_ENV  := ${PROJECT_ENV}
PROJECT_NAME := ${PROJECT_NAME}
STACK_NAME   := $(PROJECT_NAME)-alb-$(PROJECT_ENV)

################################################################################
# タスク
################################################################################
.PHONY: create
create: # CFnのスタック作成
	aws cloudformation create-stack --stack-name $(STACK_NAME) --template-body file://./main.yaml --parameters ParameterKey=ProjectName,ParameterValue=$(PROJECT_NAME) ParameterKey=Environment,ParameterValue=$(PROJECT_ENV)

.PHONY: update
update: # CFnのスタック更新
	aws cloudformation update-stack --stack-name $(STACK_NAME) --template-body file://./main.yaml --parameters ParameterKey=ProjectName,ParameterValue=$(PROJECT_NAME) ParameterKey=Environment,ParameterValue=$(PROJECT_ENV)

.PHONY: delete
delete: # CFnのスタック削除
	aws cloudformation delete-stack --stack-name $(STACK_NAME)

.PHONY: list-parameter-store
list-parameter-store: # CFnで作ったParameterStore一覧
	aws ssm get-parameters-by-path --path "/$(PROJECT_NAME)/$(PROJECT_ENV)/" | jq -rc '.Parameters[] | {name: .Name, value: .Value}'
