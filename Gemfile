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
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails',   '~> 5.0'
gem 'turbolinks',   '~> 5'
gem 'uglifier',     '>= 1.3.0'
gem 'webpacker'

# to be removed when ffi bug fixed
# gem 'ffi', '1.9.18'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

  ### Capistrano
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'

  ### Rspec
  gem 'rspec', '~> 3.5'
  gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
  gem 'rspec_junit_formatter', '~> 0.3.0'
end

group :development do
  gem 'listen',                '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console',           '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
