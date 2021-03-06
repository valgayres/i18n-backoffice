require 'i18n-backoffice/version.rb'
require 'i18n'
require 'redis'
require 'i18n-backoffice/hash'
require 'i18n-backoffice/web'

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

      def initial_translations(load = false)
        return if @initial_translations && load
        @initial_translations ||= I18n.backend.send(:translations)
      end

      def reinitialize_translations
        I18n.backend.load_translations
      end

      def last_update_in_redis
        Time.parse(redis.get('I18n_translation_updated_at'))
      end

      def update_translation_if_needed
        reload_translation_from_redis if Time.now - config.last_update > config.update_frequency
      end

      def reload_translation_from_redis
        initial_translations(true)
        i18n_translations(true).deep_merge!(translations(true).dig_hashed_by_spliting_keys.get_locales) if last_update_in_redis > config.last_update
        config.last_update = Time.now
      end

      def store_translations_in_redis(translations_hash)
        redis.mapped_hmset('I18n_translations', translations.merge(translations_hash.get_locales.deep_flatten_by_stringification))
        redis.set('I18n_translation_updated_at', Time.now)
      end

      def translate(*args)
        update_translation_if_needed
        I18n.translate(*args)
      end

      alias :t :translate

    })

  end
end
