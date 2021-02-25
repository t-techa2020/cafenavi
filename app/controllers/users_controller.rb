class UsersController < ApplicationController
  before_action :require_logged_in, only: [:index, :show, :followings, :followers, :likes]
  before_action :authenticate_user!, only: [:destroy] 

  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @cafeposts = @user.cafeposts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = '退会しました'
    
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
