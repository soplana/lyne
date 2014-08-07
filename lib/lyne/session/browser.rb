module Lyne::Session
  # sessionの維持
  # ページ遷移などのブラウザの動き
  class Browser
    include ScreenTransitions

    def initialize options
      @options = options.reverse_merge(default_options)
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, {
          js_errors: false,
          timeout:   1000,
          phantomjs: @options[:phantomjs]
        })
      end
      Capybara.default_selector = :xpath
      @page = Capybara::Session.new(:poltergeist)
      @page.driver.headers = {'User-Agent' => @options[:user_agent]}

      setup_cache
    end

    def start!
      go :welcome
      go :character_select
      self
    end

    def first_visit!
      return if @page.current_path == '/sc/home/'
      character_select_url? ? go(:home) : visit(:home)
    end

    def go type
      __send__("go_to_#{type}")
    end

    def visit type
      __send__("visit_to_#{type}")
    end

    def html
      @page.html
    end

    private
    def default_options
      {
        account:      '',
        password:     '',
        character_id: 0,
        user_agent:   'Mozilla/5.0 (Macintosh; Intel Mac OS X)',
        phantomjs:    Phantomjs.path
      }
    end

    def login_url
      url =  'https://secure.square-enix.com/account/app/svc/login?'
      url += 'cont=dq_comm&'
      url += 'svcgrp=Service_SEJ&'
      url += 'retu=http%3A%2F%2Fhiroba.dqx.jp%2Fsc%2F&'
      url += 'retl=dqx_p&ret=https%3A%2F%2Fsecure.dqx.jp%2Fsc%2Flogin%2Fexec%3Fp%3D0%26ott%3Dfeb84a119a6b2f7df40aac09a9c42f90'
    end

    def character_select_url?
      @page.current_path == "/sc/login/characterselect/"
    end

    def setup_cache
      @cache = {}
    end
  end
end
