#!/usr/bin/env bash

set -e

DEPLOY_HISTORY_FILE=log/stg_deploy_version.log

# create version file if it does not exist
if [ ! -e "$DEPLOY_HISTORY_FILE" ]; then
  mkdir -p log && touch $DEPLOY_HISTORY_FILE
fi

# fetch
git fetch --prune

# get release branch to deploy
RELEASE_BRANCH=`git branch --sort=-committerdate -r | \
                grep origin/release | \
                head -n 1 | \
                sed 's/^[[:space:]]*//' | \
                sed -e 's/origin\///g'`

echo $RELEASE_BRANCH

# get hotfix branch to deploy
HOTFIX_BRANCH=`git branch --sort=-committerdate -r | \
               grep origin/hotfix | \
               head -n 1 | \
               sed 's/^[[:space:]]*//' | \
               sed -e 's/origin\///g'`

echo $HOTFIX_BRANCH

# exit if nothing to deploy or both release and hotfix branches exist
if [[ ! -z "$RELEASE_BRANCH" && ! -z "$HOTFIX_BRANCH" ]] || [[ -z "$RELEASE_BRANCH" && -z "$HOTFIX_BRANCH" ]]; then
  echo 'nothing to deploy or both branches exist'
  exit 0;
fi

# get last deployed branch
LAST_DEPLOYED_BRANCH=`cat $DEPLOY_HISTORY_FILE`

# post to slack
post_to_slack () {
  data='{ "text": "'$*'" }'
  curl -X POST -H 'Content-type: application/json' --data "$data" \
       https://hooks.slack.com/services/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
}

# deploy branch
deploy_branch () {
  branch="$1"
  if [ ! -z "$branch" ] && [ "$branch" != "$LAST_DEPLOYED_BRANCH" ]; then
     message="deploying $branch to staging server 🎉 "

     # let us know that deployment has started
     post_to_slack "*START:* $message"

     # checkout branch
     git checkout $branch

     # deploy to staging
     bundle exec cap staging deploy

     # update deployed history
     echo "$branch" > $DEPLOY_HISTORY_FILE

     # let us know that deployment has finished
     post_to_slack "*FINISH:* $message"
  fi
}


deploy_branch $RELEASE_BRANCH
deploy_branch $HOTFIX_BRANCH
