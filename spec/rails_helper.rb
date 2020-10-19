# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
# Coverage report generator
require 'simplecov'
SimpleCov.start
# filter out support specs, tests
SimpleCov.add_filter 'spec/support'

require 'capybara/rails'

require 'rails/test_help'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, executable_path: "/usr/bin/chromedriver")
end

Capybara.javascript_driver = :selenium

Rails.application.load_seed

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
    config.include SpecTestHelper, :type => :controller
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  
  config.include Capybara::DSL

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
