# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# rails db:reset does not apply new migrations
task :resetdb do
  sh 'rails db:drop && rails db:create && rails db:migrate && rails db:seed'
end
