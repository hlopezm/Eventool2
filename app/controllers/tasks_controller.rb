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
    authorize @task

      if @task.update update_params
         redirect_to @task, notice: "#{@task.name} updated"
      else
        render 'edit'
      end
    end

 def new
    @task = current_user.tasks.build
  end

  def create
    @task = Tasks.new(task_params)
        authorize @task

    if @task.save
      redirect_to @task
    else
      render :new
    end
  end


 private

    def set_task
      @task = Task.find params[:id]
    end

  def task_params
    params.require(:task).permit(:admin)
  end

  def update_params
      params.require(:task).permit(:admin)
  end


end
