# encoding: utf-8

require 'erb'
require 'sinatra/base'
require 'i18n-backoffice/helpers'

module I18n
  module Backoffice
    class Web < Sinatra::Base

      enable :sessions
      use Rack::Protection, :use => :authenticity_token unless ENV['RACK_ENV'] == 'test'

      set :root, File.expand_path(File.dirname(__FILE__) + '/../../web')
      set :views, proc { "#{root}/views" }

      helpers Helpers

      get "/translations" do
        @translations = I18n::Backoffice.translations
        erb :translations
      end

      get "/translations/:locale" do
        render status: 404 and return unless params[:locale].in? I18n.available_locales
        @initial_translations = I18n::Backoffice.initial_translations.select {|k,_v| k.match(/\A#{params[:locale]}/)}
        @custom_translations  = I18n::Backoffice.translations

        erb :translations
      end

      post "/translations/save_translations" do

        redis.mapped_hmset('I18n_translations', translations.merge(params[:translations].select{|_k,v| v.present?}))
        redis.set('I18n_translation_updated_at', Time.now)
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
