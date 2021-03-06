class UsersController < ApplicationController
  include BCrypt
  before_filter :authenticate_user, :get_user, :only => [:profile, :securityquestion, :securityquestion_submit, :update_password, :updatepassword_submit]


  def new
    @user = User.new
    @counties = CaCountyInfo.find(:all)
    @counties_array = {}.tap{ |h| @counties.each{ |c| h[c.name] = c.fips } }
  end

  def create
   if  user_params[:password] ==  user_params[:password_confirmation]
    access = User.has_access_code?(user_params)
    if access
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = "You signed up successfully"
        @uid = @user.id
        session[:user_id] = @user.id
        session[:county] =  @user.county
        session[:expires_at] = Time.current + 3.hours
        redirect_to  securityquestion_user_path(@user)
      else
          puts @user.errors.inspect
          flash[:error]  =  "There was a problem create your account"
          redirect_to :signup
      end
    else
        flash[:error]  = "Error: Invalid Access Code. Please enter a valid access code"
        redirect_to :signup
    end
     else
       flash[:error] = "Passwords do not match. Please try again"
        redirect_to :signup
     end
  end

  def login
  end

  def logout
    reset_session
    redirect_to :login
  end

  def login_attempt
    @authorized_user, @chkd = User.authenticate(params[:username_or_email], params[:login_password])
    if @chkd
       flash[:notice] =  "Welcome again, you logged in as #{@authorized_user.username}"
      @uid =  @authorized_user.id
      @ucounty =  @authorized_user.county
      session[:user_id] = @authorized_user.id
      session[:county] = @ucounty
      session[:expires_at] = Time.current + 3.hours
      redirect_to(profile_user_path (@uid))
    else
      flash[:error] = "Invalid Username or Password"
      render :login
    end
  end

  def show
  end

  def security_question
  end

  def forgot_password
  end

  def reset_password
      @authorized_user, @chkd = User.authenticate_security_question(user_params[:username_or_email],user_params[:security_answer])
       if @chkd
         session[:user_id] = @authorized_user.id
         session[:county] = @ucounty
         session[:expires_at] = Time.current + 3.hours
         redirect_to update_password_user_path(@authorized_user.id)
      else
       flash[:error] = "Error: Invalid User Name Or You did not correctly answer the security question. Please try again."
      render :login
      end
  end

  def update_password
  end

  def updatepassword_submit
    if user_params[:password] ==  user_params[:password_confirmation]
      @newpass = Hash.new()
       encrypted_password = User.encrypt_password_update( user_params[:password], @user[:salt])
       if encrypted_password.size  > 0
        @newpass[:encrypted_password]  = encrypted_password
        if  @user.update_attributes(  @newpass)
         flash[:notice]  = "Succeessfully Updated Your Password"
          redirect_to(profile_user_path (@user))
      else
        flash[:error] = "Unable to save your new password. Please try again."
        redirect_to :login
      end
    else
        flash[:error] = "Unable to save your new password. Please try again."
        redirect_to :login
      end
    else
      flash[:error] = "Passwords do not match. Please try again"
      redirect_to update_password_user_path(@user[:id])
    end
  end


  #need to encrypt the security question before inserting it
  def securityquestion_submit
     @securityhash = Hash.new()
     @securityhash[:security_answer] = BCrypt::Engine.hash_secret( user_params[:security_answer], @user[:salt])
     @securityhash[:security_question] = user_params[:security_question]
      if  @user.update_attributes( @securityhash)
      flash[:notice]  = "Succeessfully Updated Your Security Question and Answer"
      redirect_to(profile_user_path (@user))
    else
      flash[:error] =  "Could not save your security question and answer. Please try again"
      puts @user.errors.inspect
      redirect_to securityquestion_user_path(@user)
   end
  end


  def profile
    @user = get_user
    @county =  CaCountyInfo.where(:id => @user[:county]).first!
  end

    def isEmail(str)
     return str.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]\.)[a-zA-Z]{2,4}/)
    end


  def user_params
    params.require(:user).permit(:status, :username, :email, :county,   :password, :password_confirmation, :access_code, :security_question, :security_answer, :username_or_email )
  end


end
