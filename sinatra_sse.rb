require 'sinatra/base'
require 'bundler'
Bundler.require(:default, :development, ENV['RACK_ENV'])

class SinatraSse < Sinatra::Base
  set :server, 'thin'
  @@connections = []

  get '/' do
    haml :index
  end

  get '/stream', :provides => 'text/event-stream' do
    stream :keep_open do |out|
      @@connections << out
      out.callback { @@connections.delete(out) }
    end
  end

  post '/' do
    @@connections.each { |out| out << "data: #{params[:msg]}\n\n" }
    204 # response without entity body
  end
end
