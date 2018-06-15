# frozen_string_literal: true

set :stage,          :staging
set :branch,         :develop
set :rails_env,      :staging
set :bundle_without, :production

set :servers, fetch(:credentials)[:servers]

fetch(:servers).each do |server|
  set :hostname,    server['hostname']
  set :username,    server['username']
  set :id_rsa_file, server['id_rsa_file']

  server fetch(:hostname),
         user: fetch(:username),
         roles: %w[app web db],
         ssh_options: { keys: fetch(:id_rsa_file) }
end

set :ssh_options,
    forward_agent: true,
    auth_methods:  %w[publickey]
# proxy: Net::SSH::Proxy::Command.new('ssh -o StrictHostKeyChecking=no jotaay-bastion -W %h:%p')
