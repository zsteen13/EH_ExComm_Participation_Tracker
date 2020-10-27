# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# rake db:reset does not apply new migrations
task :resetdevdb do
  sh 'rake db:drop RAILS_ENV=development && rake db:create  RAILS_ENV=development && rake db:migrate RAILS_ENV=development && rake db:seed RAILS_ENV=development'
end

task :resettestdb do
  'rake db:drop RAILS_ENV=test && rake db:create RAILS_ENV=test && rake db:migrate RAILS_ENV=test && rake db:seed RAILS_ENV=test'
end
