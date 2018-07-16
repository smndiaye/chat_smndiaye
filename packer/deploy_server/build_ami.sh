#!/usr/bin/env bash

set -e

packer build packer/deploy_server/templates/deploy_server.json
