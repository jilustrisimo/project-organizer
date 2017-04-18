class ProjectsController < ApplicationController

  get '/projects' do
    check_if_logged_in
    @projects = current_user.projects.order(:due_date)
    erb :'/projects/index.html'
  end

  get '/projects/new' do
    check_if_logged_in
    erb :'/projects/new.html'
  end

  post '/projects' do
    project = current_user.projects.build(params[:project])
    if project.save
      redirect "/projects/#{project.id}"
    else
      flash[:notice] = project.errors.full_messages.uniq.join(', ')
      redirect '/projects/new'
    end
  end

  get '/projects/:id' do
    check_if_logged_in
    check_if_project_exists
    @project = Project.find_by(id: params[:id])
    @task = @project.tasks.build
    @project.update_if_completed
    if @project.user == current_user
      erb :'/projects/show.html'
    else
      flash[:notice] = 'You can only view you own projects.'
      redirect to '/projects'
    end
  end

  get '/projects/:id/edit' do
    check_if_logged_in
    check_if_project_exists
    @project = Project.find_by(id: params[:id])
    if @project.user_id == current_user.id
      erb :'/projects/edit.html'
    else
      flash[:notice] = 'You can only edit your own projects.'
      redirect to '/projects'
    end
  end

  patch '/projects/:id' do
    project = Project.find_by_id(params[:id])
    project.update(params[:project])
    if project.save
      redirect to "/projects/#{project.id}"
    else
      flash[:notice] = project.errors.full_messages.uniq.join(', ')
      redirect to "/projects/#{project.id}/edit"
    end
  end

  delete '/projects/:id/delete' do
    project = current_user.projects.find_by(id: params[:id])
    project.tasks.delete_all
    project.delete
    session.delete(:project_id)
    redirect '/projects'
  end
end
