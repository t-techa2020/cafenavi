class BeanpostsController < ApplicationController
  before_action :require_logged_in, only: [:index, :show, :search]
  before_action :authenticate_owner!, only: [:new, :create]
  before_action :correct_owner, only: [:edit, :destroy]
  
  def index
    @beanposts = Beanpost.all.page(params[:page]).per(10)
  end

  def show
    @beanpost = Beanpost.find(params[:id])
  end
  
  def new
    @beanpost = Beanpost.new
  end
  
  def create
    @beanpost = current_owner.beanposts.build(beanpost_params)
    if @beanpost.save
      flash.now[:success] = '商品を投稿しました。'
      redirect_to @beanpost
    else
      flash.now[:danger] = '商品の投稿に失敗しました。'
      render :new
    end
  end
  
  def edit
    @beanpost = Beanpost.find(params[:id])
  end
  
  def update
    @beanpost = Beanpost.find(params[:id])

    if @beanpost.update(beanpost_params)
      flash[:success] = '商品は正常に更新されました'
      redirect_to @beanpost
    else
      flash.now[:danger] = '商品は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @beanpost.destroy
    flash[:success] = '商品を削除しました。'
    redirect_to root_url
  end
  
  def search
    if params[:search].present?
      if Beanpost.where('name LIKE ?', "%#{params[:search]}%") == []
         @beanposts = Beanpost.all.page(params[:page])
         flash.now[:danger] = '商品は見つかりませんでした'
      else
         @beanposts = Beanpost.where('name LIKE ?', "%#{params[:search]}%").page(params[:page])
      end
    else
      @beanposts = Beanpost.all.page(params[:page])
    end
  end
  
  private
  
  def beanpost_params
    params.require(:beanpost).permit(:name, :image, :amount, :price, :country, :remove_image)
  end
  
  def correct_owner
    @beanpost = current_owner.beanposts.find_by(id: params[:id])
    unless @beanpost
      redirect_to root_url
    end
  end
end
