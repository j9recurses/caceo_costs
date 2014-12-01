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
    if session[:user_id]
      # set current user object to @current_user object variable
      @current_user = User.find_by_id(session[:user_id])
      return true
    else
      redirect_to(login_path)
      return false
    end
  end

end
