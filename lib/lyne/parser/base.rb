# Lyne::Util::Sessionからhtml情報を受け取り
# 必要に応じてパースする
module Lyne::Parser
  class Base
    def initialize session
      @session = session
      yield if block_given?
      set_result
    end

    def nbsp
      Nokogiri::HTML("&nbsp;").text
    end

    private
    def set_result
      @result = Nokogiri::HTML.parse(@session.html)
    end

    def get_parse_data option
      raise Lyne::Error::ParseError.new if parse_data.blank?
      option = option.reverse_merge(default_parse_result_options)
      text   = parse_data.children[option[:index]].children.text
      text   = if option[:regexp].present?
                 text.gsub(option[:regexp], '')
               else
                 text
               end
      text.gsub(/\s|#{nbsp}/,'')
    end

    def default_parse_result_options
      {}
    end

    def parse_data
      @parse_data ||= @result.xpath(parse_target_xpath)
    end
  end
end
