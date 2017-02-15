class TasksController < ApplicationController

  # GET: /tasks
  get "/tasks" do
    erb :"/tasks/index.html"
  end

  get "/tasks/new" do
    check_if_logged_in
    @project = Project.find_by(id: session[:project_id])
    erb :"/tasks/new.html"
  end

  post "/tasks" do
    project = Project.find_by(id: session[:project_id])
    task = Task.create(params[:task])
    if task.save
      task.update(project_id: session[:project_id])
      redirect "/projects/#{project.id}"
    else
      flash[:notice] = task.errors.full_messages.uniq.join(', ')
      redirect to '/tasks/new'
    end
  end

  # # GET: /tasks/5
  # get "/tasks/:id" do
  #   erb :"/tasks/show.html"
  # end

  get '/tasks/:id/edit' do
    check_if_logged_in
    @task = Task.find_by(id: params[:id])
    if @task.project_id == session[:project_id]
      session[:task_id] = @task.id
      erb :'/tasks/edit.html'
    else
      flash[:notice] = 'You can only edit your own tasks.'
      redirect to '/tasks'
    end
  end

  patch '/tasks/:id' do
    task = Task.find_by_id(params[:id])
    task.update(params[:task])
    if task.save
      redirect to "/tasks/#{task.id}"
    else
      flash[:notice] = task.errors.full_messages.uniq.join(', ')
      redirect to "/tasks/#{task.id}/edit"
    end
  end

  delete '/tasks/:id/delete' do
    task = Task.find_by(id: session[:task_id])
    if task
      task.delete
      session.delete(:task_id)
    else
      flash[:notice] = 'You can only delete your own tasks.'
    end
    redirect to "/projects/#{session[:project_id]}"
  end
end
