# frozen_string_literal: true

require "test_helper"

class MarshmallowTest < Minitest::Test
  test "it has a version number" do
    refute_nil Marshmallow::VERSION
  end
end
