# encoding: utf-8

require 'erb'
require 'sinatra/base'


module I18n
  module Backoffice
    class Web < Sinatra::Base

      enable :sessions
      use Rack::Protection, :use => :authenticity_token unless ENV['RACK_ENV'] == 'test'

      set :root, File.expand_path(File.dirname(__FILE__) + "/../../web")
      set :views, proc { "#{root}/views" }

      get "/translations" do
        @translations = I18n::Backoffice.translations
        erb :translations
      end
    end
  end
end

if defined?(::ActionDispatch::Request::Session) &&
    !::ActionDispatch::Request::Session.respond_to?(:each)
  class ActionDispatch::Request::Session
    def each(&block)
      hash = self.to_hash
      hash.each(&block)
    end
  end
end
