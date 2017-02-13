class UsersController < ApplicationController

  # GET: /users
  # get "/users" do
  #   erb :"/users/index.html"
  # end

  get '/signup' do
    erb :'users/signup.html'
  end

  # POST: /users
  post '/signup' do
    redirect '/users'
  end

  # GET: /users/5
  get '/users/:id' do
    erb :'/users/show.html'
  end

  # DELETE: /users/5/delete
  delete '/users/:id/delete' do
    redirect '/users'
  end
end
