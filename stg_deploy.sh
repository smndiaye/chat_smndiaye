#!/usr/bin/env bash

set -e

TYPE=$1

# exit if incorrect argument given
if [ "$TYPE" != "hotfix" ] && [ "$TYPE" != "release" ]; then
  exit 2
fi

# fetch
git fetch --prune

# get branch to deploy
BRANCH=`git branch --sort=-committerdate -r | \
        grep origin/$TYPE | \
        head -n 1 | \
        sed 's/^[[:space:]]*//' | \
        sed -e 's/origin\///g'`

# exit if branch does not exist
if [ -z "$BRANCH" ]; then
  exit 0;
fi

# create version file if it does not exist
DEPLOY_HISTORY_FILE=log/"$TYPE"_deploy_version.log
if [ ! -e "$DEPLOY_HISTORY_FILE" ]; then
  mkdir -p log && touch $DEPLOY_HISTORY_FILE
fi

# get last deployed commit
LAST_DEPLOYED_COMMIT=`cat $DEPLOY_HISTORY_FILE`

# get latest commit from branch to deploy
LATEST_COMMIT=`git log -n 1 origin/$BRANCH --pretty=format:"%H"`

# exit if no new commit
if [ "$LAST_DEPLOYED_COMMIT" == "$LATEST_COMMIT" ]; then
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
message="deploying $BRANCH to staging server 🎉 "
post_to_slack "*START:* $message"

# checkout and get latest deploy config
git checkout "$BRANCH"
git pull

# deploy to staging
export CAPISTRANO_BRANCH="$BRANCH"
bundle exec cap staging deploy

# update deployed history
echo "$LATEST_COMMIT" > "$DEPLOY_HISTORY_FILE"

# checkout deploy branch
git checkout deploy

# let us know that deployment has finished
post_to_slack "*FINISH:* $message"

echo "############# DEPLOY FINISH: `date '+%Y-%m-%d %H:%M:%S'` #############"
