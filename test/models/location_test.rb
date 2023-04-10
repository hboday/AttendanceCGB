require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  setup do
    create_locations
  end

  should validate_presence_of(:name)

  should validate_uniqueness_of(:name).case_insensitive
end