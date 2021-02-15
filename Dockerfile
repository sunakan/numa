FROM node:14-buster-slim
RUN apt-get update \
  && apt-get install -y curl unzip make jq git

################################################################################
# AWS CLI v2
################################################################################
WORKDIR /tmp/
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && /tmp/aws/install \
  && rm -rf /tmp/aws/
################################################################################
# Serverless Framework
################################################################################
RUN npm install -g serverless \
  && npm install -g serverless-prune-plugin \
  && npm install -g serverless-step-functions

WORKDIR /var/local/app/
