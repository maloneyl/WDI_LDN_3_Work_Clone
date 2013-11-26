class TasksController < ApplicationController

  def index
    respond_to do |format|
      format.html {render nothing: true, layout: true} # i.e. render empty layout to make room for our Ember yield
      format.json {render json: {tasks: Task.all}} # notes: 1. Task here refers to task.rb (which we'll create in app/models); 2. there will be a gem we can use in the future for this rendering
    end
  end

  def create
    task = Task.create params[:task] # params is the object from ember
    render json: {task: task}
  end

  def update
    task = Task.find params[:id]
    task.update_attributes params[:task]
    render json: {task: task}
  end

  def destroy
    task = Task.find params[:id]
    task.delete
    render nothing: true # Ember expects an empty response
  end

end
