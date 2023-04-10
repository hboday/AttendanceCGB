ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest"
require "minitest/rails"
require "minitest/reporters"
require "minitest_extensions"
require "contexts"

class ActiveSupport::TestCase
  def deny(condition, msg="")
    assert !condition, msg
  end
  Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end