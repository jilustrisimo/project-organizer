class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup.html'
  end

  post '/signup' do
    if !logged_in?
      params[:user][:username].downcase!
      #=> set to make username input case insensitive
      user = User.create(params[:user])
      if user.save
        session[:user_id] = user.id
        redirect '/projects/new'
      else
        flash[:notice] = user.errors.full_messages.uniq.join(', ')
        redirect to '/signup'
      end
    else
      redirect '/projects'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/projects'
    else
      erb :'/users/login.html'
    end
  end

  post '/login' do
    params[:user][:username].downcase!
    #=> set to make username input case insensitive
    user = User.find_by(username: params[:user][:username])
    if user
      if user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        redirect to '/projects'
      else
        flash[:notice] = 'Invalid password'
        redirect to '/login'
      end
    else
      flash[:notice] = 'Invalid username'
      redirect to '/login'
    end
  end

  get '/logout' do
    raise session.inspect
    if logged_in?
      session.clear
      flash[:notice] = 'Successfully logged out.'
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  # DELETE: /users/5/delete
  delete '/users/:id/delete' do
    redirect to '/users'
  end
end
