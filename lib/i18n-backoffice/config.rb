module I18n
  module Backoffice
    class Config

      def redis
        @redis
      end

      def last_update
        (@last_update ||= Time.at(0)).in_time_zone
      end

      def update_frequency
        @update_frequency ||= 10.minutes
      end

      def redis=(redis)
        raise "Warning during initialization, #{redis} is not a Redis instance" unless redis.class == Redis
        @redis = redis
      end

      def last_update=(last_update)
        @last_update = last_update
      end

      def update_frequency=(frequency)
        @update_frequency = frequency
      end
    end
  end
end