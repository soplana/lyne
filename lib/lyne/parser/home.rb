module Lyne::Parser
  class Home < Lyne::Parser::Base
    def initialize session
      super(session) do
        @session.first_visit!
      end
    end

    def name
      get do
        @result.xpath("//h2[@id='myCharacterName']").text.gsub(/\[|\]/, '')
      end
    end

    def job
      get_info_data do {index: 11} end
    end

    def tribe
      get_info_data do
        {index: 7, regexp: /：|#{nbsp}|男|女/}
      end
    end

    def level
      get_info_data do {index: 15} end
    end

    def id
      get_info_data do {index: 3} end
    end

    def next_level
      get_info_data do {index: 19} end
    end

    def gold
      get_info_data do {index: 23} end
    end

    def genki_charge
      get_info_data do {index: 27} end
    end

    private
    def get_info_data
      get do
        raise Lyne::Error::ParseError.new if info_data.blank?
        option = yield.reverse_merge({regexp: /：|#{nbsp}/})
        info_data.children[option[:index]].children.text.gsub(option[:regexp], '')
      end
    end

    def info_data
      @info_data ||= (@result.xpath("//div[@id='myCharacterStatusList']").children.presence || [])[1]
    end
  end
end
