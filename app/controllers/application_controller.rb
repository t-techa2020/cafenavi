class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cafename, :name, :address])
  end
  
  private

  def require_logged_in
    unless user_signed_in? || owner_signed_in?
      redirect_to new_user_session_path
    end
  end
  
  def counts(user)
    @count_cafeposts = user.cafeposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likes = user.likes.count
  end
end
