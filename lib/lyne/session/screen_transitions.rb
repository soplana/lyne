module Lyne::Session
  module ScreenTransitions
    def go_to_welcome
      move_to do
        @page.visit login_url
        @page.fill_in '_pr_confData_sqexid', with: @options[:account]
        @page.fill_in '_pr_confData_passwd', with: @options[:password]
        @page.find(:xpath, ".//a[@id='btLogin']").click
      end
    end

    def go_to_character_select
      move_to do
        @page.find(:xpath, "//a[@href='/sc/login/characterselect/']").click
      end
    end

    def go_to_home
      move_to do
        @page.find(:xpath, "//a[@rel='#{@options[:character_id]}']").click
      end
    end

    def visit_to_home
      move_to do
        @page.visit('sc/home/')
      end
    end

    private
    def move_to
      yield
      sleep(2)
    end
  end
end
