module I18n
  module Backoffice
    class Config

      def redis
        @redis
      end

      def last_update
        @last_update.in_time_zone
      end

      def redis=(redis)
        raise "Warning during initialization, #{redis} is not a Redis instance" unless redis.class == Redis
        @redis = redis
      end

      def last_update=(last_update)
        @last_update = last_update
      end
    end
  end
end