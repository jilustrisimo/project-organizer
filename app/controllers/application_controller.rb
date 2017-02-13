require './config/environment'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, '%B1F2Oi*aj%ZD69#sbpxZ48%MQDbIo'
  end

  get '/' do
    erb :welcome
  end

end
