class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception
  protected


  def get_user
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
    else
      redirect_to(login_path)
    end
    return @user
  end

  def authenticate_user
    if current_user
      true
    else
      redirect_to(login_path)
      false
    end
  end

private
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
end
