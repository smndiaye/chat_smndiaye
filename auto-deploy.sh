#!/usr/bin/env bash

set -e

DEPLOY_HISTORY_FILE=deploy-version.txt

# create version file if it does not exist
if [[ ! -e "$DEPLOY_HISTORY_FILE" ]]; then
    echo 'create deploy history file'
    touch $DEPLOY_HISTORY_FILE
fi

# fetch new tags from remote
git fetch --tags

# get last commit
LAST_COMMIT=`git rev-list --tags --max-count=1`

# get latest tag name
NEW_TAG=`git describe --tags $LAST_COMMIT`

# get last deployed tag
LAST_TAG=`cat $DEPLOY_HISTORY_FILE`

# exit if not new tag
if [ "$NEW_TAG" == "$LAST_TAG" ] ; then
  echo 'same as last one'
  exit 0;
fi

# deploy to staging
bundle exec cap staging deploy

# update deployed tag
echo "$NEW_TAG" > $DEPLOY_HISTORY_FILE

# let us know over slack
curl -X POST -H 'Content-type: application/json' \
--data '{"text":"tag version '$NEW_TAG' was deployed to staging! 🎉"}' \
https://hooks.slack.com/services/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