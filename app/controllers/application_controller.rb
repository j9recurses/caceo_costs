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
  # def print_session
  #   vars = session.instance_variables
  #   vars.each do |v|
  #     puts "#{v}: #{session.instance_variable_get(v)}"
  #   end
  # end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

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
      referrer = request.referrer
      referrer_params = Rails.application.routes.recognize_path( referrer )
      permitted = current_permissions.allow?(
        referrer_params[:controller], 
        referrer_params[:action], 
        current_resource
        ) || 
        current_permissions.allow?(
          referrer_params[:controller], 
          referrer_params[:action], 
          current_session)
      if referrer && permitted
        redirect_to :back
      elsif current_user
        redirect_to profile_user_path
      else
        redirect_to login_path
      end
      flash[:error] = "Not Authorized."
    end
    devmode_authorize_output
  end

  def devmode_authorize_output
    if Rails.env.development?
    puts <<-TEXT 
    AUTHORIZATION--controller: #{params[:controller]}
    AUTHORIZATION--action: #{params[:action]}
    AUTHORIZATION--county: #{current_user ? current_user.county_id : 'not signed in'}
    AUTHORIZATION--session[:county_id]: #{current_session ? current_session[:county_id].to_s : 'no session' }
    AUTHORIZATION--resource[:county_id]: #{current_resource ? current_resource[:county_id].to_s : 'no resource' }
    TEXT
    end
  end

  def current_permissions
    @current_permissions = Permission.new(current_user)
  end
end
