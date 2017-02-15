require './config/environment'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, '%B1F2Oi*aj%ZD69#sbpxZ48%MQDbIo'
    use Rack::Flash, sweep: :true
  end

  get '/' do
    redirect to '/login'
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by(id: session[:user_id])
    end

    def check_if_logged_in
      unless logged_in?
        flash[:notice] = 'Please log in first.'
        redirect to '/login'
      end
    end

    def check_if_project_exists
      redirect to '/projects' if Project.all.find_by_id(params[:id]).nil?
    end

    def check_if_task_exists
      redirect to '/projects' if Task.all.find_by_id(params[:id]).nil?
    end
  end
end
