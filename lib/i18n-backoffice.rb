require 'i18n-backoffice/version.rb'
require 'i18n'
require 'redis'
require 'i18n-backoffice/hash'

module I18n
  module Backoffice
    autoload :Config, 'i18n-backoffice/config'

    extend(Module.new {
      def config
        @config ||= Config.new
      end

      def config=(value)
        @config = value
      end

      def redis
        config.redis
      end

      def translations(reload = false)
        if reload
          @translations = redis.hgetall('I18n_translations')
        end
        @translations ||= redis.hgetall('I18n_translations')
      end

      def i18n_translations(reload = false)
        if reload
          @i18n_translations = I18n.backend.send(:translations)
        end
        @i18n_translations ||= I18n.backend.send(:translations)
      end

      def reinitialize_translations
        I18n.backend.load_translations
      end

      def reload_translation_from_redis
        return unless redis
        i18n_translations(true).deep_merge!(translations(true).dig_hashed_by_spliting_keys)
      end
    })
  end
end
