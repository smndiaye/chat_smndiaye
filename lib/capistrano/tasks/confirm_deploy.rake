# frozen_string_literal: true

# confirm production deploy
namespace :deploy do
  task :confirm_deploy do
    puts <<-WARN
    ===========================================================================
                  WARNING: 本番環境にデプロイしようとしています　！！！　　
    ===========================================================================
    WARN
    ask :value, '実行してもよろしいでしょうか (Y)'

    if fetch(:value) != 'Y'
      puts "\n本番環境のデプロイをキャンセルしました"
      exit
    end
  end
end
