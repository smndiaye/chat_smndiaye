# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.10.0'

set :application, 'jotaay'
set :repo_url, 'git@github.com:smndiaye/jotaay.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/apps/jotaay'

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
  desc 'Copy files'
  task :copy_master_key do
    on roles(:all) do
      execute "cp /var/apps/files/master.key #{release_path}/config/"
    end
  end

  # confirm production deploy
  task :confirm_deploy do
    puts <<-WARN
    ================================================
       WARNING: 本番環境にデプロイしようとしています　！！！　　
    ================================================
    WARN
    ask :value, '実行してよろしいでしょうか (Y)'

    if fetch(:value) != 'Y'
      puts "\n本番環境のデプロイをキャンセルしました"
      exit
    end
  end

  # validate tag
  task :push_new_tag do
    last_tag = `git tag`.split("\n").last
    puts [
      '================================================',
      '   INFO: Gitタグバージョン設定',
      "   前のタグバージョン: #{last_tag}",
      '================================================'
    ].join("\n")

    ask :new_tag_version, '新しいタグバージョンを入力してください'
    ask :new_tag_version, '正しい新しいタグバージョンを入力してください' while
        fetch(:new_tag_version) !~ /^(\d+\.){2}(\d+)$/

    puts "git tag #{fetch(:new_tag_version)}"
    puts `git tag #{fetch(:new_tag_version)}`

    puts "git push origin tag #{fetch(:new_tag_version)}"
    puts `git push origin tag #{fetch(:new_tag_version)}`
  end
end

before 'deploy:symlink:release', 'deploy:copy_master_key'
after 'deploy:publishing', 'deploy:restart'
after 'deploy:log_revision', 'deploy:push_new_tag'

Capistrano::DSL.stages.each do |stage|
  after stage, 'deploy:confirm_deploy' if stage == 'staging'
end
