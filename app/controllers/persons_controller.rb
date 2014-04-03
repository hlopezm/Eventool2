class PersonsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_person, only: [:edit, :update, :destroy]

  def index
    if params[:event_id].present?
      @persons = Event.find(params[:event_id]).persons
    else
      @persons = Person.all
    end

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
    @url = persons_path
  end

  def create
      @person = Person.new(create_params)

    if @person.save
      redirect_to @person
    else
      render :new
    end
  end

  def edit
  @person = Person.find(params[:id])
  @url = person_path(@person)
  end

  def update
    @person= Person.find(params[:id])
   
  	if @person.update update_params
      redirect_to person_path, notice: "#{@person.name} updated"
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
    params.require(:person).permit(*policy(Person).edit_permitted_attrs)
  end
end

