require 'sinatra/base'
require 'bundler'
Bundler.require(:default, :development, ENV['RACK_ENV'])

class SinatraSse < Sinatra::Base
  get '/' do
    haml :index
  end
end
