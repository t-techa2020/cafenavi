class CafepostsController < ApplicationController
  before_action :require_logged_in, only: [:index, :show, :search]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :correct_user, only: [:edit, :destroy]
  
  def index
    @cafeposts = Cafepost.all.page(params[:page]).per(10)
  end

  def show
    @cafepost = Cafepost.find(params[:id])
  end
  
  def new
    @cafepost = Cafepost.new
  end
  
  def create
    @cafepost = current_user.cafeposts.build(cafepost_params)
    if @cafepost.save
      sleep(10)
      flash.now[:success] = 'カフェを投稿しました。'
      render :show
    else
      @cafeposts = current_user.feed_cafeposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'カフェの投稿に失敗しました。'
      @all_ranks = Cafepost.find(Favorite.group(:cafepost_id).order('count(cafepost_id) desc').limit(6).pluck(:cafepost_id))
      render :new
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
    if params[:search].present?
      if Cafepost.where('name LIKE ?', "%#{params[:search]}%") == []
         @cafeposts = Cafepost.all.page(params[:page]).per(10)
         flash.now[:danger] = 'カフェは見つかりませんでした'
      else
         @cafeposts = Cafepost.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(10)
      end
    else
      @cafeposts = Cafepost.all.page(params[:page]).per(10)
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
