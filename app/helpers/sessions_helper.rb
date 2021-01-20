module SessionsHelper
  def current_user
    # @current_user ||= User.find_by(id: session[:user_id])
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        @current_user = user
      end
    end
  end

  def logged_in?
    !!current_user
  end
  
  def remember(user)
    user.remember #Userモデルで定義したrememberメソッド。記憶トークンを作成、ハッシュ化してDBに保存
    cookies.permanent.signed[:user_id] = user.id #ユーザーIDを暗号化してcookieに保存
    cookies.permanent[:remember_token] = user.remember_token #記憶トークンをcookieに保存
  end
  
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
end
