# frozen_string_literal: true

set :stage, :staging
set :branch, 'staging'
set :rails_env, 'staging'
set :bundle_without, 'production'

server '54.178.42.25', user: 'ec2-user', roles: %w[web app]

set :ssh_options, keys: %w[~/.ssh/id_rsa_11cba49f92d1565316b56b3456d6e43a],
                  forward_agent: true,
                  auth_methods: %w[publickey]
