#!/usr/bin/env bash

set -e

# fetch new tags from remote
git fetch --tags

# get last commit
LAST_COMMIT=`git rev-list --tags --max-count=1`

# get latest tag name
NEW_TAG=`git describe --tags $LAST_COMMIT`

# create version file if it does not exist
DEPLOY_HISTORY_FILE=log/prod_deploy_version.log
if [ ! -e "$DEPLOY_HISTORY_FILE" ]; then
  mkdir -p log && touch $DEPLOY_HISTORY_FILE
fi

# get last deployed tag
LAST_TAG=`cat $DEPLOY_HISTORY_FILE`

# exit if no new tag
if [ "$NEW_TAG" == "$LAST_TAG" ] ; then
  exit 0;
fi

# post to slack method
post_to_slack () {
  data='{ "text": "'$*'" }'
  curl -X POST -H 'Content-type: application/json' --data "$data" \
       https://hooks.slack.com/services/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
}

echo "############# DEPLOY START: `date '+%Y-%m-%d %H:%M:%S'` #############"

# let us know that deployment has started
message="deploying tag $NEW_TAG to production server 🎉 "
post_to_slack "*START:* $message"

# deploy to production
git checkout "$NEW_TAG"
bundle exec cap staging deploy

# update deployed tag
echo "$NEW_TAG" > $DEPLOY_HISTORY_FILE

# checkout deploy branch
git checkout deploy

# let us know that deployment has finished
post_to_slack "*FINISH:* $message"

echo "############# DEPLOY FINISH: `date '+%Y-%m-%d %H:%M:%S'` #############"
