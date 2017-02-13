class UsersController < ApplicationController

  # GET: /users
  # get "/users" do
  #   erb :"/users/index.html"
  # end

  get '/signup' do
    erb :'/users/signup.html'
  end

  # POST: /users
  post '/signup' do
    params[:user][:username].downcase!
    user = User.create(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect '/projects/new'
    else
      flash[:notice] = user.errors.full_messages.uniq.join(', ')
      erb :'/users/signup.html'
    end
  end

  # GET: /users/5
  get '/login' do
    erb :'/users/login.html'
  end

  post '/login' do
    params[:user][:username].downcase!
    user = User.find_by(username: params[:user][:username])
    if user
      if user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        redirect to '/projects/new'
      else
        flash[:notice] = "Invalid password"
        erb :'/users/login.html'
      end
    else
      flash[:notice] = "Invalid username"
      erb :'/users/login.html'
    end
  end
  
  # DELETE: /users/5/delete
  delete '/users/:id/delete' do
    redirect '/users'
  end
end
