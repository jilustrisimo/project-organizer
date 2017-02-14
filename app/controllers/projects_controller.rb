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
    @project = Project.find_by_id(params[:id])
    erb :'/projects/show.html'
  end

  get '/projects/:id/edit' do
    if logged_in?
      @project = Project.find_by(id: params[:id])
      if @project.user_id == current_user.id
        # binding.pry
        erb :'/projects/edit.html'
      else
        flash[:notice] = 'You can only edit your own projects.'
        erb :'/projects/edit.html'
      end
    else
      flash[:notice] = 'Please log in first to view projects.'
      erb :'/users/login.html'
    end
  end

  patch '/projects/:id' do
    @project = Project.find_by_id(params[:id])
    @project.update(params[:project])
    if @project.save
      redirect "/projects/#{@project.id}"
    else
      flash[:notice] = @project.errors.full_messages.uniq.join(', ')
      @project = Project.find_by_id(params[:id])
      erb :'/projects/edit.html'
    end
  end

  # DELETE: /projects/5/delete
  delete '/projects/:id/delete' do
    redirect '/projects'
  end
end
