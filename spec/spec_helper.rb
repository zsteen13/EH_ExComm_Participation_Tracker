<<<<<<< HEAD
# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    # => "be bigger than 2"
=======

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
   # => "be bigger than 2"
>>>>>>> e6f339b3... Create ruby.yml for CI testing (#30)
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
