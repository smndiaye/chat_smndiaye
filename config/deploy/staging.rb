# frozen_string_literal: true

set :stage,          :staging
set :branch,         :develop
set :rails_env,      :staging
set :bundle_without, :production

server '54.64.20.99', user: 'ec2-user', roles: %w[app web db]

set :ssh_options, keys:          %w[~/.ssh/id_rsa_11cba49f92d1565316b56b3456d6e43a],
                  forward_agent: true,
                  auth_methods:  %w[publickey]
# proxy: Net::SSH::Proxy::Command.new('ssh -o StrictHostKeyChecking=no jotaay-bastion -W %h:%p')
