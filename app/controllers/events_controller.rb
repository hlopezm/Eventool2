class EventsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event, only: [:edit, :update, :destroy]

  def index
  end

  def list
    render :json => Event.all
  end

  def invite_people
    event = Event.find(params[:event_id])
    new_ids = params[:people_ids].collect{|i| i.to_i} - event.people.map(&:id)
    people_new = Person.where(:id => new_ids)
    event.people.append(people_new)
    render :text => "ok"
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(create_params)

    authorize @event

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    authorize @event
  end

  def operation
    
  end

  def update
    authorize @event

    if @event.update update_params
      redirect_to @event, notice: "#{@event.name} updated"
    else
      render 'edit'
    end
  end

  def destroy
    authorize @event

    @event.destroy
    redirect_to events_path, notice: "#{@event.name} was removed"
  end

  def today
    @events = Event.for_today
    render 'index'
  end

  def next_week
    @events = Event.next_week
    render 'index'
  end

  def mine
    if current_user
      @events = current_user.events
      render 'index'
    else
      redirect_to events_path
    end
  end

  private

  def set_event
    @event = Event.find params[:id]
  end

  def create_params
    params.require(:event).permit(*policy(Event).new_permitted_attrs)
  end

  def update_params
    params.require(:event).permit(*policy(@event).edit_permitted_attrs)
  end
end
