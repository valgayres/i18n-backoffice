module I18n
  module Backoffice
    class Config

      def redis
        @redis
      end

      def redis=(redis)
        raise "Warning during initialization, #{redis} is not a Redis instance" unless redis.class == Redis
        @redis = redis
      end
    end
  end
end