################################################################################
# 変数
################################################################################
PROJECT_ENV  := ${PROJECT_ENV}
PROJECT_NAME := ${PROJECT_NAME}
STACK_NAME   := $(PROJECT_NAME)-ecs-cluster-$(PROJECT_ENV)

################################################################################
# マクロ
################################################################################
# $(1): create or update
define cfn-stack
aws cloudformation $(1)-stack \
  --stack-name $(STACK_NAME) \
  --template-body file://./main.yaml \
  --parameters \
    ParameterKey=ProjectName,ParameterValue=$(PROJECT_NAME) \
    ParameterKey=Environment,ParameterValue=$(PROJECT_ENV)
endef

################################################################################
# タスク
################################################################################
.PHONY: create
create: ## CFnのスタック作成
	$(call cfn-stack,$@)

.PHONY: update
update: ## CFnのスタック更新
	$(call cfn-stack,$@)

.PHONY: delete
delete: ## CFnのスタック削除
	aws cloudformation delete-stack --stack-name $(STACK_NAME)

.PHONY: list-parameter-store
list-parameter-store: # CFnで作ったParameterStore一覧
	aws ssm get-parameters-by-path --path "/$(PROJECT_NAME)/$(PROJECT_ENV)/" | jq -rc '.Parameters | sort_by(.Name) | .[] | {name: .Name, version: .Version, value: .Value}'
