# frozen_string_literal: true

require "test_helper"

class AbstractSyntaxTreeTest < Minitest::Test
  def setup
    @ast = Marshmallow::AbstractSyntaxTree.new
  end

  test "it can generate simple ruby arrays" do
    # Arrange
    @ast.open_array
    @ast.add_scalar(1)
    @ast.add_scalar(2)
    @ast.add_scalar(3)
    @ast.close_array

    # Act
    ruby_str = @ast.to_ruby

    # Assert
    assert_equal [1, 2, 3], ruby_str
  end

  test "it can generate simple ruby hashes" do
    # Arrange
    @ast.open_object
    @ast.add_scalar("foo")
    @ast.add_scalar(42)
    @ast.close_object

    # Act
    ruby_str = @ast.to_ruby

    # Assert
    assert_equal({ "foo" => 42 }, ruby_str)
  end
end
