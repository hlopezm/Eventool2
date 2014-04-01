class PersonsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_person, only: [:edit, :update, :destroy]

  def index
    @persons = Person.all

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def create
      @person = Person.new(params[:person].permit(:title, :text))

    if @person.save
      redirect_to @person
    else
      render :new
    end
  end

  def edit
    authorize @person
  end

  def update
    authorize @person

    if @person.update update_params
      redirect_to @person, notice: "#{@person.name} updated"
    else
      render 'edit'
    end
  end

  def destroy
    authorize @person

    @person.destroy
    redirect_to persons_path, notice: "#{@person.name} was removed"
  end


  private

  def set_person
    @person = Person.find params[:id]
  end

  def create_params
    params.require(:person).permit(*policy(Person).new_permitted_attrs)
  end

  def update_params
    params.require(:person).permit(*policy(@person).edit_permitted_attrs)
  end
end

