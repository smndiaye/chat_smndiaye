#!/usr/bin/env bash

set -e

# get last develop commit
LATEST_COMMIT=`git log -n 1 origin/develop  --pretty=format:"%H"`

# create version file if it does not exist
DEPLOY_HISTORY_FILE=log/edge_deploy_version.log
if [ ! -e "$DEPLOY_HISTORY_FILE" ]; then
  mkdir -p log && touch $DEPLOY_HISTORY_FILE
fi

# get last deployed commit
LAST_DEPLOYED_COMMIT=`cat $DEPLOY_HISTORY_FILE`

# exit if no new commit
if [ "$LAST_DEPLOYED_COMMIT" == "$LATEST_COMMIT" ] ; then
  echo 'same as last one'
  exit 0;
fi

# post to slack method
post_to_slack () {
  data='{ "text": "'$*'" }'
  curl -X POST -H 'Content-type: application/json' --data "$data" \
       https://hooks.slack.com/services/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
}

# checkout develop with latest deploy config then deploy
git checkout develop
git pull

# let us know that deployment has started
post_to_slack "*START:* deploying develop content to edge server 🎉 "

# deploy to edge
bundle exec cap staging deploy

# update deploy history
echo "$LATEST_COMMIT" > $DEPLOY_HISTORY_FILE

# let us know that deployment has finished
post_to_slack "*FINISH:* deploying develop content to edge server 🎉 "
