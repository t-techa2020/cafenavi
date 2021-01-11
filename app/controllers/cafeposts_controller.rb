class CafepostsController < ApplicationController
  
  before_action :require_user_logged_in
  
  def create
    @cafepost = current_user.cafeposts.build(cafepost_params)
    if @cafepost.save
      flash[:success] = 'カフェを投稿しました。'
      redirect_to root_url
    else
      @cafeposts = current_user.cafeposts.order(id: :desc).page(params[:page])
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
end
