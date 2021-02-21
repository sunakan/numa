################################################################################
# 変数
################################################################################
PROJECT_NAME := ${PROJECT_NAME}
STACK_NAME   := $(PROJECT_NAME)-codebuild-shared

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
  --capabilities CAPABILITY_IAM
endef

# $(1): shared or $(PROJECT_ENV)
define parameters-by-path
aws ssm get-parameters-by-path \
  --path "/$(PROJECT_NAME)/$(1)/" \
| jq -rc '.Parameters | sort_by(.Name) | .[] | {name: .Name, version: .Version, value: .Value}'
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
list-parameter-store: ## CFnで作ったParameterStore一覧
	$(call parameters-by-path,shared)

.PHONY: describe
describe: ## CFnで作ったStackの様子
	aws cloudformation describe-stacks --stack-name $(STACK_NAME) | jq -r '.Stacks[0] | {name: .StackName, status: .StackStatus}'

.PHONY: watch
watch: ## CFnで作ったStackの様子をwatch
	watch -n 2 make describe
