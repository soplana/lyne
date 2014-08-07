module Lyne::Page
  module Hook
    module CreateProperty
      def self.included(target_class)
        target_class.class_eval do
          self::PROPERTYS.each do |property|
            define_method(property) do
              @parser.__send__(property)
            end
          end
        end
      end
    end
  end
end
