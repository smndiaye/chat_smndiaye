# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

### Server Side ###
gem 'jbuilder', '~> 2.5'
gem 'puma',     '~> 3.7'
gem 'rails',    '~> 5.2.0'
gem 'unicorn'

### API ###
gem 'grape'
gem 'grape-entity'
gem 'grape-rails-routes'

### Database ###
gem 'pg'

### Front Side ###
gem 'coffee-rails'
gem 'markdown-rails'
gem 'sass-rails'
gem 'turbolinks'
gem 'uglifier'
gem 'webpacker'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'selenium-webdriver'

  ### Rspec
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :deploy do
  ### Capistrano
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
end
