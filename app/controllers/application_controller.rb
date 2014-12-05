class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected

  delegate :allow?, to: :current_permissions
  helper_method :allow?

  before_filter :authorize

  def get_user
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
    else
      redirect_to(login_path)
    end
    return @user
  end

private
  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def current_resource
    nil
  end

  def current_session
    nil
  end

  def authorize
    if current_permissions.allow?(params[:controller], params[:action], current_resource)
    elsif current_permissions.allow?(params[:controller], params[:action], current_session)
    else
      if request.env["HTTP_REFERER"]
        redirect_to :back
      elsif current_user
        redirect_to home_path
      else
        redirect_to login_path
      end
      flash[:error] = "Not Authorized."
    end
  end

  def current_permissions
    @current_permissions = Permission.new(current_user)
  end
end
