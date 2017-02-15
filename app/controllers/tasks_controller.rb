class TasksController < ApplicationController

  get '/tasks/new' do
    check_if_logged_in
    @project = Project.find_by(id: session[:project_id])
    erb :'/tasks/new.html'
  end

  post '/tasks' do
    task = Task.create(params[:task])
    if task.save
      task.update(project_id: session[:project_id])
      redirect "/projects/#{task.project_id}"
    else
      flash[:notice] = task.errors.full_messages.uniq.join(', ')
      redirect to '/tasks/new'
    end
  end

  get '/tasks/:id/edit' do
    check_if_logged_in
    check_if_task_exists
    @task = Task.find_by(id: params[:id])
    if @task.project_id == session[:project_id]
      session[:task_id] = @task.id
      erb :'/tasks/edit.html'
    else
      flash[:notice] = 'You can only edit your own tasks.'
      redirect to '/projects'
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
    task.delete
    session.delete(:task_id)
    redirect to "/projects/#{session[:project_id]}"
  end
end
