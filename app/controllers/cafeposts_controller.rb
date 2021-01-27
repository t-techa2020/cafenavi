class CafepostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy]
  
  def index
    @cafeposts = Cafepost.all.page(params[:page])
  end

  def show
    @cafepost = Cafepost.find(params[:id])
  end
  
  def create
    @cafepost = current_user.cafeposts.build(cafepost_params)
    if @cafepost.save
      flash[:success] = 'カフェを投稿しました。'
      redirect_to root_url
    else
      @cafeposts = current_user.feed_cafeposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'カフェの投稿に失敗しました。'
      @all_ranks = Cafepost.find(Favorite.group(:cafepost_id).order('count(cafepost_id) desc').limit(6).pluck(:cafepost_id))
      render 'toppages/index'
    end
  end
  
  def edit
    @cafepost = Cafepost.find(params[:id])
  end
  
  def update
    @cafepost = Cafepost.find(params[:id])

    if @cafepost.update(cafepost_params)
      flash[:success] = 'カフェは正常に更新されました'
      @all_ranks = Cafepost.find(Favorite.group(:cafepost_id).order('count(cafepost_id) desc').limit(6).pluck(:cafepost_id))
      render :show
    else
      flash.now[:danger] = 'カフェは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @cafepost.destroy
    flash[:success] = 'カフェを削除しました。'
    redirect_to root_url
  end
  
  def search
    if params[:name].present?
      @cafeposts = Cafepost.where('name LIKE ?', "%#{params[:name]}%")
    else
      @cafeposts = Cafepost.none
    end
  end
  
  private
  
  def cafepost_params
    params.require(:cafepost).permit(:content, :image, :name, :prefecture, :address, :remove_image)
  end
  
  def correct_user
    @cafepost = current_user.cafeposts.find_by(id: params[:id])
    unless @cafepost
      redirect_to root_url
    end
  end
end
