class ToppagesController < ApplicationController
  def index
    if logged_in?
      @cafepost = current_user.cafeposts.build  # form_with 用
      @cafeposts = current_user.cafeposts.order(id: :desc).page(params[:page])
    end
  end
end
