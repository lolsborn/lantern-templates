require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/vendor/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Serializers', 'app/serializers'
  add_group 'Services', 'app/services'
  add_group 'Jobs', 'app/jobs'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Run specs in random order
  config.order = :random
  Kernel.srand config.seed

  # Disable should syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Profile slowest examples
  config.profile_examples = 10 if ENV['CI']

  # Fail fast
  config.fail_fast = true if ENV['FAIL_FAST']
end