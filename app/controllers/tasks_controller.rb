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
    @task = Task.find params[:id]

     if @task.update  update_params
        redirect_to @task, notice: "#{@task.name} updated"
     else
        render 'edit'
     end
    end

     def new
        @task = Task.new
      end

    def create

      @task = Task.find params[:id] task_params

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
