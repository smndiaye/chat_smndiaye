# frozen_string_literal: true

# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Load the SCM plugin appropriate to your project:
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
# require "capistrano/rvm"
require 'capistrano/rbenv'
set :rbenv_type, :user
set :rbenv_custom_path, '/home/ec2-user/.rbenv'
# require "capistrano/chruby"
require 'capistrano/bundler'
require 'capistrano3/unicorn'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
# require "capistrano/passenger"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
