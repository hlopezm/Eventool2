class TasksController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    if params[:event_id].present?
      @tasks = Event.find(params[:event_id]).tasks
    else
      @tasks = Task.all.to_json(:include => :user)
    end
  end

  def show
  	@task = Task.find(params[:id])
  end

  def new
   @task = current_user.tasks.build
  end

  def create
    @task = Task.new(create_params)

    if @task.save
      redirect_to @task
    else
      render :new
    end
  end

  def edit
    authorize @task
  end

  def update
    authorize @task

     if @task.update  update_params
        redirect_to @task, notice: "#{@task.title} updated"
     else
        render 'edit'
     end
    end

  def destroy
    authorize @task

    @task.destroy
    redirect_to tasks_path, notice: "#{@task.name} was removed"
  end 


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

end

