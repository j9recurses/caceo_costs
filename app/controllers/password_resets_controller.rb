class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset if user
    redirect_to root_url, notice: "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by( password_reset_token: params[:id] )
    if @user.nil? || @user.password_reset_sent_at < 2.hours.ago
      flash[:error] = "Password reset has expired. Please try again."
      redirect_to new_password_reset_url 
    end
  end

  def update
    @user = User.find_by!( password_reset_token: params[:id] )
    if params[:user][:password] == params[:user][:password_confirmation]
      encrypted_password = User.encrypt_password_update( params[:user][:password], @user[:salt])
      if encrypted_password.size > 0
        if @user.update_attributes( encrypted_password: encrypted_password )
          flash[:notice]  = "Succeessfully Updated Your Password"
          redirect_to(profile_user_path (@user))
        else
          flash[:error] = "Unable to save your new password. Please try again."
          render :edit
        end
      else
        flash[:error] = "Unable to save your new password. Please try again."
        render :edit
      end
    else
      flash[:error] = "Passwords do not match. Please try again."
      render :edit
    end
  end
end