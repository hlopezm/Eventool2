class GuestsController < ApplicationController

  def index
    @guests = Guest.all
  end

  def show
    @guest = Guest.find(params[:id])
  end

  def new
    @guest = current_user.guests.build
  end

  def create
    @guest = current_user.guests.build(create_params)

    authorize @guest

    if @guest.save
      redirect_to @guest
    else
      render :new
    end
  end

  def edit
    authorize @guest
  end

  def update
    authorize @guest

    if @guest.update update_params
      redirect_to @guest, notice: "#{@guest.name} updated"
    else
      render 'edit'
    end
  end

  def destroy
    authorize @guest

    @guest.destroy
    redirect_to guests_path, notice: "#{@guest.name} was removed"
  end

  def today
    @guests = Guest.for_today
    render 'index'
  end

  def next_week
    @guests = Guest.next_week
    render 'index'
  end

  def mine
    if current_user
      @guests = current_user.events
      render 'index'
    else
      redirect_to guests_path
    end
  end

  private

  def set_event
    @guest = Guest.find params[:id]
  end

  def create_params
    params.require(:event).permit(*policy(Guest).new_permitted_attrs)
  end

  def update_params
    params.require(:event).permit(*policy(@guest).edit_permitted_attrs)
  end

end
