class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    cafepost = Cafepost.find(params[:cafepost_id])
    current_user.favorite(cafepost)
    flash[:success] = 'お気に入り登録しました'
    redirect_to root_url
  end

  def destroy
    cafepost = Cafepost.find(params[:cafepost_id])
    current_user.unfavorite(cafepost)
    flash[:success] = 'お気に入りを解除しました'
    redirect_to root_url
  end
end
