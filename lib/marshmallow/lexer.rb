require "strscan"

module Marshmallow
  # Our simple lexer that will recognize the basic tokens:
  # :STRING, :NUMBER, :TRUE, :FALSE, and :NULL
  class Lexer
    def initialize
      @scanner = StringScanner.new ""
    end

    def feed(input)
      @scanner << input
    end

    def next_token # rubocop:disable Metrics/MethodLength
      return [false, false] if @scanner.eos?

      if (text = @scanner.scan(/\d+/))
        [:NUMBER, text.to_i]
      elsif (text = @scanner.scan(/"[a-z]+"/))
        [:STRING, text]
      elsif @scanner.scan(/true/)
        [:TRUE, true]
      elsif @scanner.scan(/false/)
        [:FALSE, false]
      elsif @scanner.scan(/null/)
        [:NULL, nil]
      else
        text = @scanner.getch
        [text, text]
      end
    end
  end
end
