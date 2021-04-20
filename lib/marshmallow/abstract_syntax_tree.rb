# frozen_string_literal: true

module Marshmallow
  # The AST object that will be produced by the parser and consumed by the code generator
  class AbstractSyntaxTree
    attr_reader :root

    def initialize
      @stack = []
      @root = Node.new(:root)
      @last_node = @root
    end

    def open_array
      new_array = Node.new(:array)
      @last_node.children << new_array
      @last_node = new_array

      @stack.push new_array
    end

    def close_array
      @stack.pop
    end

    def open_object
      new_object = Node.new(:object)
      @last_node.children << new_object
      @last_node = new_object

      @stack.push new_object
    end

    def close_object
      @stack.pop
    end

    def add_scalar(val)
      active_node = @stack.last
      active_node.children << Node.new(:scalar, val) and return if active_node.type == :array

      # If the last object pair is incomplete
      if active_node.children.last && active_node.children.last.children.count < 2
        active_node.children.last.children << Node.new(:scalar, val)
      else # Create a new pair node and attach the first child
        new_pair = Node.new(:pair)
        new_pair.children << Node.new(:scalar, val)
        active_node.children << new_pair
      end
    end

    def to_ruby
      build(@root.children.first)
    end

    private

    def build(node)
      return node.children.map { |c| build(c) } if node.type == :array
      return node.children.inject({}) { |a, c| a.merge(build(c)) } if node.type == :object
      return Hash[*node.children.map(&:value)] if node.type == :pair

      node.value
    end

    # The specific nodes in this AbstractSyntaxTree
    class Node
      attr_reader :type, :value, :children

      def initialize(type, val = nil)
        @type = type
        @value = val
        @children = []
      end
    end
  end
end
