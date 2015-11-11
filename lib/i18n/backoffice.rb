require 'i18n/backoffice/version.rb'

module I18n
  module Backoffice
    #autoload :Config, 'i18n/backoffice/config'

    extend(Module.new {
      def config
     #   @config ||= Config.new
      end

      def config=(value)
        @config = value
      end

      def redis
        config.redis
      end
    })
  end
end
