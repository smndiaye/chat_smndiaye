#!/usr/bin/env bash

set -e

for i in "$@"
do
 case $i in
  --repo-url=*)
  REPO_URL="${i#*=}"
  ;;
 esac
done

if [ -z "$REPO_URL" ]; then
  echo "repo is not provided"
  exit 2
fi

REPO_NAME=$(basename $REPO_URL .git)

# dependencies
sudo yum -y update
sudo yum -y install git git-core zlib zlib-devel gcc-c++ patch readline \
                    readline-devel libyaml-devel libffi-devel openssl-devel \
                    make bzip2 autoconf automake libtool bison curl postgresql-devel

# rbenv and ruby build
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile

# git repository
git clone $REPO_URL
cd $REPO_NAME

# ruby
rbenv install

# gems
gem install bundler
rbenv rehash
bundle install
