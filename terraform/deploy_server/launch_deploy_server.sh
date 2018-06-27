#!/bin/bash

set -e

terraform get
terraform apply -var-file=tfvars/deploy_server_ami.tfvars -auto-approve=false
