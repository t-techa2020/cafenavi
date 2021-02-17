class OwnersController < ApplicationController
  before_action :require_logged_in
  before_action :require_owner_logged_in, only: [:destroy]
  before_action :current_owner, only: [:destroy]
  
  def index
    @owners = Owner.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @owner = Owner.find(params[:id])
  end
  
  def destroy
    @owner = Owner.find(params[:id])
    @owner.destroy
    flash[:success] = '退会しました'
    
    redirect_to root_url
  end
  
  private
  
  def owner_params
    params.require(:owner).permit(:cafename, :name, :email, :address, :password, :password_confirmation)
  end
end
