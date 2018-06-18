# frozen_string_literal: true

# push new release tag
namespace :deploy do
  task :push_new_tag do
    tags = `git tag`.split("\n")
    last_tag = tags.last
    puts last_tag_msg = ['========================================',
                         "       前のタグバージョン: #{last_tag}",
                         '========================================'].join("\n")

    ask :skip_tag, '新しいタグバージョンを設定しますか (Y)'
    if fetch(:skip_tag) != 'Y'
      puts "\n新しいタグバージョン設定をキャンセルしました"
      exit
    end

    loop do
      ask :new_tag_version, '新しい有効なタグバージョンを入力してください。'
      if tags.include? fetch(:new_tag_version)
        puts "タグバージョンは既に存在しています。\n" + last_tag_msg
        next
      end
      break if fetch(:new_tag_version) =~ /^(\d+\.){2}(\d+)$/
    end

    new_tag_version = fetch(:new_tag_version)
    puts `git tag #{new_tag_version}`
    puts "新しい #{new_tag_version} タグバージョンを作成しました"
    puts `git push origin tag #{new_tag_version}`
    puts "#{new_tag_version} タグバージョンをプッシュしました"
  end
end
