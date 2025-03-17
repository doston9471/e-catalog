ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "database_cleaner/mongoid"

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  # Setup Database Cleaner
  setup do
    DatabaseCleaner[:mongoid].strategy = :deletion
    DatabaseCleaner[:mongoid].start
  end

  teardown do
    DatabaseCleaner[:mongoid].clean
  end
end
