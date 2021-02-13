class OwnersController < ApplicationController
  def index
    @owners = Owner.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @owner = Owner.find(params[:id])
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    
    if @owner.save
      flash[:success] = 'オーナーを登録しました。'
      redirect_to @owner
    else
      flash.now[:danger] = 'オーナーの登録に失敗しました。'
      render :new
    end
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
