# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'simplecov'
SimpleCov.start
SimpleCov.add_filter 'spec/support'
require 'capybara/rails'
require 'capybara/email/rspec'
require 'rails/test_help'

require 'selenium-webdriver'

DOWNLOAD_PATH = Rails.root.join('tmp/downloads').to_s

Capybara.register_driver :chrome do |app|
  profile = Selenium::WebDriver::Chrome::Profile.new
  profile['download.default_directory'] = DOWNLOAD_PATH
  Capybara::Selenium::Driver.new(app, browser: :chrome, profile: profile)
end

Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome

Capybara.default_max_wait_time = 10

# Rails.application.load_seed

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.include SpecTestHelper, type: :controller
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.before(:each) do
    config.include Capybara::DSL
  end

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
  Capybara.server_port = 3001
  Capybara.app_host = 'http://localhost:3001'
end
