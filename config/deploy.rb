# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'jotaay'
set :repo_url, 'git@github.com:smndiaye/jotaay.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/apps/jotaay'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets'

append :linked_files, 'config/master.key'

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  # custom task
  desc 'Copy files'
  task :copy_master_key do
    on roles(:all) do
      execute "cp /var/apps/files/master.key #{release_path}/config/"
    end
  end
end

before 'deploy:symlink:linked_dirs', 'deploy:copy_master_key'
after 'deploy:publishing', 'deploy:restart'
after 'deploy:restart', 'deploy:push_new_tag'

Capistrano::DSL.stages.each do |stage|
  after stage, 'deploy:confirm_deploy' if stage == 'staging'
end
