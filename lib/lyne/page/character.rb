# ページ毎にオブジェクトに切り出す
module Lyne::Page
  # Character情報に紐づくオブジェクト
  module Character
    class Base
      #include Lyne::Page::ShowTable

      def initialize session
        @parser = parser_class.new(session)
      end

      private
      def parser_class
        Lyne::Parser::Home
      end
    end

    # Target以下のClassが実際の機能として提供される
    # それぞれの機能が必要とするパーサを必ず指定する必要がある
    module Target
      class Info < Lyne::Page::Character::Base
        PROPERTYS = %w(name job tribe level next_level genki_charge id gold)
        include Lyne::Page::Hook::CreateProperty

        def initialize session
          super
        end

        private
        def table_headers
          %w(ID 名前 種族 職業 レベル 次のレベルまで 所持金 元気チャージ)
        end

        def table_rows
          [id, name, job, tribe, level, next_level, gold, genki_charge]
        end
      end

      class Arms < Lyne::Page::Character::Base
        def name
        end

        private
        def parser_class
          Lyne::Parser::Home
        end
      end
    end

    # 実際の機能をLyne::Account（外部からのインターフェイス）に
    # 提供する為のClass
    # ドラクエ10Account内に複数キャラがいる場合などは
    # キャラの切り替えなども発生するため
    class Adapter
      def initialize session
        @session   = session
        @character = Lyne::Page::Character::Base.new(session)
      end

      Lyne::Page::Character::Target.constants.each do |target|
        formatted_name = target.to_s.downcase
        define_method(formatted_name) do
          if instance_variable_defined?("@#{formatted_name}")
            return instance_variable_get("@#{formatted_name}")
          else
            instance_variable_set("@#{formatted_name}", Lyne::Page::Character::Target.const_get(target).new(@session))
          end
        end
      end
    end
  end
end
