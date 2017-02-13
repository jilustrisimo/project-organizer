class ProjectsController < ApplicationController

  get '/projects' do
    erb :'/projects/index.html'
  end

  get '/projects/new' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'/projects/new.html'
    else
      flash[:notice] = 'Please log in first to create a project.'
      erb :'/users/login.html'
    end
  end

  post '/projects' do
    project = Project.create(params[:project])
    if project.save
      project.update(user_id: current_user.id)
      redirect "/projects/#{project.id}"
    else
      flash[:notice] = project.errors.full_messages.uniq.join(', ')
      erb :'/projects/new.html'
    end
  end

  get '/projects/:id' do
    @project = Project.find(params[:id])
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
