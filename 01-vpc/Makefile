################################################################################
# 変数
################################################################################
PROJECT_NAME    := ${PROJECT_NAME}
STACK_BASE_NAME := $(PROJECT_NAME)-vpc

################################################################################
# マクロ
################################################################################
# $(1): 環境(dev,stg,prd)
define create-stack
  aws cloudformation create-stack --stack-name $(STACK_BASE_NAME)-$(1) --template-body file://./vpc.yaml --parameters ParameterKey=ProjectName,ParameterValue=$(PROJECT_NAME) ParameterKey=Environment,ParameterValue=$(1)
endef

# $(1): 環境(dev,stg,prd)
define update-stack
  aws cloudformation update-stack --stack-name $(STACK_BASE_NAME)-$(1) --template-body file://./vpc.yaml --parameters ParameterKey=ProjectName,ParameterValue=$(PROJECT_NAME) ParameterKey=Environment,ParameterValue=$(1)
endef


################################################################################
# タスク
################################################################################
.PHONY: create
create: # CFnのスタック作成(全環境分)
	$(call create-stack,dev)
#	$(call create-stack,stg)
#	$(call create-stack,prd)

.PHONY: update
update: # CFnのスタック更新(全環境分)
	$(call update-stack,dev)
#	$(call update-stack,stg)
#	$(call update-stack,prd)

.PHONY: delete
delete: # CFnのスタック削除(全環境分)
	aws cloudformation delete-stack --stack-name $(STACK_BASE_NAME)-dev
#	aws cloudformation delete-stack --stack-name $(STCK_BASE_NAME)-stg
#	aws cloudformation delete-stack --stack-name $(STCK_BASE_NAME)-prd

.PHONY: list-parameter-store
list-parameter-store: # CFnで作ったParameterStore一覧
	aws ssm get-parameters-by-path --path "/$(PROJECT_NAME)/dev/" | jq -rc '.Parameters[] | {name: .Name, value: .Value}'
	aws ssm get-parameters-by-path --path "/$(PROJECT_NAME)/stg/" | jq -rc '.Parameters[] | {name: .Name, value: .Value}'
	aws ssm get-parameters-by-path --path "/$(PROJECT_NAME)/prd/" | jq -rc '.Parameters[] | {name: .Name, value: .Value}'
