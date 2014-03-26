class InvitationsController < ApplicationController

  def index
  	@invitations = Invitation.all
  end

  def show
  	@invitation = Invitation.find(params[:id])
  end

  def edit
  	@invitation = Invitation.find(params[:id])
  end

  def update
  	@invitation = Invitation.find(params[:id])
  	if @invitation.update edit_parameters
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private
  def edit_parameters
    params.require(:invitation).permit(:admin)
  end
end
