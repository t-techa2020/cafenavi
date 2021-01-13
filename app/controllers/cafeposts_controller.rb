class CafepostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @cafepost = current_user.cafeposts.build(cafepost_params)
    if @cafepost.save
      flash[:success] = 'カフェを投稿しました。'
      redirect_to root_url
    else
      @cafeposts = current_user.feed_cafeposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'カフェの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @cafepost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def cafepost_params
    params.require(:cafepost).permit(:content, :image)
  end
  
  def correct_user
    @cafepost = current_user.cafeposts.find_by(id: params[:id])
    unless @cafepost
      redirect_to root_url
    end
  end
end
