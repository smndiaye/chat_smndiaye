# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.10.0'

set :application, 'chat_smndiaye'
set :repo_url, 'git@github.com:smndiaye/chat_smndiaye.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/apps/chat_smndiaye'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets'

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  # custom task
  # desc 'Copy files'
  # task :copy_files do
  #   on roles(:all) do
  #     execute "cp -r /var/apps/files/* #{release_path}/public"
  #   end
  # end
end

# before 'deploy:symlink:release', 'deploy:copy_files'
after 'deploy:publishing', 'deploy:restart'
