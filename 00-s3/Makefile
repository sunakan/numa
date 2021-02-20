################################################################################
# アプリプロジェクト用のS3バケット
################################################################################

################################################################################
# 変数
################################################################################
PROJECT_ENV      := ${PROJECT_ENV}
S3_BUCKET_NAME   := ${S3_BUCKET_BASE_NAME}-$(PROJECT_ENV)
S3_BUCKET_REGION := ap-northeast-1

################################################################################
# マクロ
################################################################################

################################################################################
# タスク
################################################################################
.PHONY: all
all:
	@make create-s3-bucket
	@make update-public-access-block

.PHONY: create-s3-bucket
create-s3-bucket: ## S3バケットの作成
	aws s3api create-bucket --bucket $(S3_BUCKET_NAME) --create-bucket-configuration LocationConstraint=$(S3_BUCKET_REGION)

.PHONY: update-public-access-block
update-public-access-block: ## S3のアクセス許可周りの設定
	aws s3api put-public-access-block --bucket $(S3_BUCKET_NAME) --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
