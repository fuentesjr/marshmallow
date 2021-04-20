# frozen_string_literal: true

require "test_helper"

class LexerTest < Minitest::Test
  def setup
    @lexer = Marshmallow::Lexer.new
  end

  test "it can identify numbers" do
    # Arrange
    input = "42"
    @lexer.feed input

    # Assert
    assert_equal [:NUMBER, 42], @lexer.next_token
  end

  test "it can identify strings" do
    # Arrange
    input = '"foobar"'
    @lexer.feed input

    # Assert
    assert_equal [:STRING, input], @lexer.next_token
  end

  test "it can identify booleans" do
    # Arrange
    input = "true false"
    @lexer.feed input

    # Assert
    assert_equal [:TRUE, true], @lexer.next_token
    assert_equal [" ", " "], @lexer.next_token
    assert_equal [:FALSE, false], @lexer.next_token
  end

  test "it can identify Nulls" do
    # Arrange
    input = "null"
    @lexer.feed input

    # Assert
    assert_equal [:NULL, nil], @lexer.next_token
  end
end
