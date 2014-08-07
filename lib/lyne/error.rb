module Lyne::Error
  class LyneError < StandardError
  end

  class ParseError < LyneError
    def initialize message='failed to parse'
      super(message)
    end
  end
end
