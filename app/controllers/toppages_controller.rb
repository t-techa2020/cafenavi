class ToppagesController < ApplicationController
  def index
    @all_ranks = Cafepost.find(Favorite.group(:cafepost_id).order('count(cafepost_id) desc').limit(6).pluck(:cafepost_id))
    @beanposts = Beanpost.order(id: :desc).limit(3)
  end
end
