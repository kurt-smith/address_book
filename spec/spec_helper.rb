# frozen_string_literal: true

require 'database_cleaner'
require 'simplecov'
require 'webmock/rspec'

SimpleCov.start 'rails'

RSpec.configure do |config|
  config.order = :random

  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    Faker::UniqueGenerator.clear

    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

# Global Helpers
def fixture(file_name, json: false, symbolize: false)
  file = File.read("./spec/fixtures/#{file_name}")
  return file unless json
  JSON.parse(file, symbolize_names: symbolize)
end
