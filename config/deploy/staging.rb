# frozen_string_literal: true

set :stage, :staging
set :branch, 'staging'
set :rails_env, 'staging'
set :bundle_without, 'production'

server '54.238.214.175', user: 'ec2-user', roles: %w[web app]

set :ssh_options, keys: %w[~/.ssh/chat-smndiaye.pem],
                  forward_agent: true,
                  auth_methods: %w[publickey]
