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

      def load_translation_from_redis
        return unless redis
        translations.each do |i18n_key, translation|
          value_to_change = i18n_base_translation; nil
          key_list = i18n_key.split('.')
          key_list_to_parse = key_list.first(key_list.length - 1)
          last_key = key_list.last
          key_list_to_parse.each do |key|
            value_to_change[key.to_sym] = {} unless value_to_change[key.to_sym].is_a?(Hash)
            value_to_change = value_to_change[key.to_sym]
          end
          value_to_change[last_key.to_sym] = translation if value_to_change
        end
      end
    })
  end
end
