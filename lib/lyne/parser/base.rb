# Lyne::Util::Sessionからhtml情報を受け取り
# 必要に応じてパースする
module Lyne::Parser
  class Base
    def initialize session
      @session = session
      yield if block_given?
      set_result
    end

    def get
      yield
    #rescue
    #  raise Lyne::Error::ParseError.new
    end

    def nbsp
      Nokogiri::HTML("&nbsp;").text
    end

    private
    def set_result
      @result = Nokogiri::HTML.parse(@session.html)
    end
  end
end
