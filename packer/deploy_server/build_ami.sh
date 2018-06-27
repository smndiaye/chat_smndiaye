#!/usr/bin/env bash

set -e

LOG_PATH=packer/deploy_server/logs/build.log
VAR_PATH=terraform/deploy_server/tfvars/deploy_server_ami.tfvars
touch $LOG_PATH
touch $VAR_PATH

packer build packer/deploy_server/templates/deploy_server.json | tee $LOG_PATH

cat $LOG_PATH | tail -n 2 \
  | sed '$ d' \
  | sed "s/ap-northeast-1: /deploy_server_ami = \"/" \
  | sed -e 's/[[:space:]]*$/\"/' > $VAR_PATH
