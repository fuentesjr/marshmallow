# frozen_string_literal: true

require "test_helper"

class LexerTest < Minitest::Test
  test "it can identify numbers" do
    # Arrange
    input = "42"
    lexer = Marshmallow::Lexer.new(input)

    # Assert
    assert_equal [:NUMBER, 42], lexer.next_token
  end

  test "it can identify strings" do
    # Arrange
    input = '"foobar"'
    lexer = Marshmallow::Lexer.new(input)

    # Assert
    assert_equal [:STRING, input], lexer.next_token
  end

  test "it can identify booleans" do
    # Arrange
    input = "true false"
    lexer = Marshmallow::Lexer.new(input)

    # Assert
    assert_equal [:TRUE, true], lexer.next_token
    assert_equal [" ", " "], lexer.next_token
    assert_equal [:FALSE, false], lexer.next_token
  end

  test "it can identify Nulls" do
    # Arrange
    input = "null"
    lexer = Marshmallow::Lexer.new(input)

    # Assert
    assert_equal [:NULL, nil], lexer.next_token
  end
end
