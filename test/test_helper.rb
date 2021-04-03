# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "marshmallow"
require "minitest/autorun"

def test(description, &block)
  method_name = "test_#{description.downcase.gsub(' ', '_')}"

  raise "Test method (#{method_name}) already defined!!" if method_defined?(method_name)

  if block_given?
    define_method(method_name.to_sym, &block)
  else
    define_method(method_name.to_sym) do
      flunk "TEST #{method_name} is not defined"
    end
  end
end
