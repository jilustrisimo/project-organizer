class ProjectsController < ApplicationController

  # GET: /projects
  get '/projects' do
    erb :'/projects/index.html'
  end

  # GET: /projects/new
  get '/projects/new' do
    @user = User.find_by(id: session[:user_id])
    erb :'/projects/new.html'
  end

  # POST: /projects
  post '/projects' do
    redirect '/projects'
  end

  # GET: /projects/5
  get '/projects/:id' do
    erb :'/projects/show.html'
  end

  # GET: /projects/5/edit
  get '/projects/:id/edit' do
    erb :'/projects/edit.html'
  end

  # PATCH: /projects/5
  patch '/projects/:id' do
    redirect '/projects/:id'
  end

  # DELETE: /projects/5/delete
  delete '/projects/:id/delete' do
    redirect '/projects'
  end
end
