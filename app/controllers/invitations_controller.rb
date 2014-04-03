class InvitationsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_invitation, only: [:edit, :update, :destroy]

  def index
    @invitations = Invitation.all

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @invitation = Invitation.find(params[:id])
  end

  def new
    @invitation = Invitation.new
    invitations_path
  end

  def create
      @invitation = Invitation.new(create_params)

    if @invitation.save
      redirect_to @invitation
    else
      render :new
    end
  end

  def edit
  @invitation = Invitation.find(params[:id])
  irvitation_path(@invitation)
  end

  def update
    @invitation= Invitation.find(params[:id])
   
  	if @invitation.update update_params
      redirect_to invitation_path, notice: "#{@invitation.name} updated"
    else
      render 'edit'
    end
  end

  def destroy
    authorize @invitation

    @invitation.destroy
    redirect_to invitations_path, notice: "#{@invitation.name} was removed"
  end


  private

  def set_invitation
    @invitation = Invitation.find params[:id]
  end

  def create_params
    params.require(:invitation).permit(*policy(Invitation).new_permitted_attrs)
  end

  def update_params
    params.require(:invitation).permit(*policy(Invitation).edit_permitted_attrs)
  end
end

