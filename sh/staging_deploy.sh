#!/usr/bin/env bash

set -ex

export AWS_DEFAULT_REGION="ap-northeast-1"
SECURITY_GROUP_ID="sg-c92548b0"

echo "Get Circle Ci IP"
IP=`timeout 10 wget -q -O - ipcheck.ieserver.net`
if [ "$?" -ne 0 ]
then
  IP=`timeout 10 curl -s -f inet-ip.info`
fi
if [ "$?" -ne 0 ]
then
  IP=`timeout 10 curl -s -f ifconfig.me`
fi


echo "Removing $IP from security group:$SECURITY_GROUP_ID on 0 1 2 3 15 signals"
trap "aws ec2 revoke-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22022 --cidr $IP/32" 0 1 2 3 15

echo "Opening up SSH on security group:$SECURITY_GROUP_ID for $IP"
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22022 --cidr $IP/32

echo "Running cap staging deploy"
bundle exec cap staging deploy
