class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup.html' unless logged_in?
    redirect to '/projects'
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
    erb :'/users/login.html' unless logged_in?
    redirect '/projects'
    # if logged_in?
    #   redirect '/projects'
    # else
    #   erb :'/users/login.html'
    # end
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
    check_if_logged_in
    session.clear
    flash[:notice] = 'Successfully logged out.'
    erb :'/users/login.html'
  end

  get '/update' do
    check_if_logged_in
    @user = current_user
    erb :'/users/settings.html'
  end

  patch '/update' do
    @user = current_user
    @user.username = (params[:user][:username])
    if @user.save
      redirect to '/projects'
    else
      flash[:notice] = @user.errors.full_messages.first
      redirect to '/update'
    end
  end

  delete '/users/:id/delete' do
    @user = current_user
    @user.delete_everything
    session.clear
    @user.delete
    redirect to '/'
  end
end
