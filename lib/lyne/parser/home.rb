module Lyne::Parser
  class Home < Lyne::Parser::Base
    def initialize session
      super(session) do
        @session.first_visit!
      end
    end
  end

  class Info < Home
    def name
      @result.xpath("//h2[@id='myCharacterName']").text.gsub(/\[|\]/, '')
    end

    def job
      get_parse_data(index: 11)
    end

    def tribe
      get_parse_data(index: 7, regexp: /：|#{nbsp}|男|女/)
    end

    def level
      get_parse_data(index: 15)
    end

    def id
      get_parse_data(index: 3)
    end

    def next_level
      get_parse_data(index: 19)
    end

    def gold
      get_parse_data(index: 23)
    end

    def genki_charge
      get_parse_data(index: 27)
    end

    private
    def default_parse_result_options
      {regexp: /：|#{nbsp}/}
    end

    def parse_target_xpath
      "//div[@id='myCharacterStatusList']"
    end

    def parse_data
      (super.children.presence || [])[1]
    end
  end

  class House < Home
    def country
      text = get_parse_data(index: 3)
      text.split[0].scan(/.*住宅村/)[0] if text.present?
    end

    def city
      text = get_parse_data(index: 3)
      text.split[0].gsub(/#{country}/,'') if text.present?
    end

    def house_number
      text = get_parse_data(index: 3)
      text.split[1] if text.present?
    end

    def setting
      get_parse_data(index: 5)
    end

    def setting_type
      get_parse_data(index: 7)
    end

    private
    def get_parse_data option
      super(option)
    rescue
      nil
    end

    def parse_target_xpath
      "//div[@id='myHouseStage']"
    end
  end
end
