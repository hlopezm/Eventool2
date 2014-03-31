class TasksController < ApplicationController

  def index
    @incomplete_tasks = Task.find(:all, :conditions => "finish IS NULL")
    @complete_tasks = Task.find(:all, :conditions => "finish IS NOT NULL")
    @tasks = Task.all
  end

  def show
  	@task = Task.find(params[:id])
  end

  def edit
  	@task = Task.find(params[:id])
  end

  def update
      @task = Task.find(params[:id])
      if @task.update edit_parameters
        redirect_to root_path
      else
        render 'edit'
      end
    end

 def new
   @task = Task.new
  end

  def create
    @task = Task.new(create_params)
 

    authorize @task

    if @task.save
      redirect_to @task
    else
      render :new
    end
  end


  #  def complete
  #  Task.update_all(["finish=?", True, :id => params[:task_ids])
  #end

    private

    def set_task
      @task = Task.find params[:id]
    end

    def create_params
      params.require(:task).permit(*policy(Task).new_permitted_attrs)
    end

    def update_params
      params.require(:task).permit(*policy(@task).edit_permitted_attrs)
    end

    def edit_parameters
      params.require(:task).permit(:admin)
  end


end
