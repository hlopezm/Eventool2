class TasksController < ApplicationController

  def index
    @incomplete_tasks = Task.find(:all, :conditions => "finish IS NULL")
    @complete_tasks = Task.find(:all, :conditions => "finish IS NOT NULL")
    @tasks = Task.all
  end
  def show
    @task = Task.find(id)
  end
  def new
    @task = tasks.build
  end


#  def complete
#  Task.update_all(["finish=?", True, :id => params[:task_ids])
#end

  private

  def set_task
    @event = Task.find params[:id]
  end

  def create_params
    params.require(:task).permit(*policy(Task).new_permitted_attrs)
  end

  def update_params
    params.require(:task).permit(*policy(@task).edit_permitted_attrs)
  end

end
