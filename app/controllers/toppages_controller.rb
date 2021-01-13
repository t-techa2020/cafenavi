class ToppagesController < ApplicationController
  def index
    if logged_in?
      @cafepost = current_user.cafeposts.build
      @cafeposts = current_user.feed_cafeposts.order(id: :desc).page(params[:page])
      @all_ranks = Cafepost.find(Favorite.group(:cafepost_id).order('count(cafepost_id) desc').limit(6).pluck(:cafepost_id))
    end
  end
end
