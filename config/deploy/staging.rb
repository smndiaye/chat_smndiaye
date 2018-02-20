# frozen_string_literal: true

set :stage, :staging
set :branch, 'staging'
set :rails_env, 'staging'
set :bundle_without, 'production'

server '13.231.226.250', user: 'ec2-user', roles: %w[web app]

set :ssh_options, keys: %w[~/.ssh/redingote.pem],
                  forward_agent: true,
                  auth_methods: %w[publickey]
