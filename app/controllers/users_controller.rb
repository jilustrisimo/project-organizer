class UsersController < ApplicationController

  get '/signup' do
    logged_in? ? (redirect to '/projects') : (erb :'/users/signup.html')
  end

  post '/signup' do
    params[:user][:username].downcase!
    #=> set to make username input case insensitive
    user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect '/projects/new'
    else
      flash[:notice] = user.errors.full_messages.uniq.join(', ')
      redirect to '/signup'
    end
  end

  get '/login' do
    logged_in? ? (redirect to '/projects') : (erb :'/users/login.html')
  end

  post '/login' do
    # set to make username input case insensitive
    params[:user][:username].downcase!
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
    user = current_user
    user.username = (params[:user][:username])
    if user.save
      redirect to '/projects'
    else
      flash[:notice] = user.errors.full_messages.first
      redirect to '/update'
    end
  end

  delete '/users/:id/delete' do
    user = current_user
    user.delete_everything
    session.clear
    user.delete
    redirect to '/'
  end
end
