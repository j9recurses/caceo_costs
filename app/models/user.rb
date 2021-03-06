
class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password
  after_save :clear_password
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 4..20 }
  validates :email, :presence => true, :uniqueness => true,   :email => true
  validates :county, :presence => true
  validates :password, :confirmation => true #password_confirmation attr
  validates_presence_of :password, :on => :create
  validates_length_of :password, :in => 5..20, :on => :create
  validates :security_question, :security_answer, :presence => true, :on => :update
  validates :fn, :ln, :dob, :presence => true , :if => :active_or_personal?
  validates :phone_number, :presence => true , :phony_plausible => true,  :if => :active_or_phone?, :length => { :is => 10}

  #methods for see which steps the form wizard is on; need to do this for vallidation
  def active?
    status == 'active'
  end

  def active_or_personal?
    (status || '').include?('personal') || active?
  end

  def active_or_phone?
    (status || '').include?('department_contact') || active?
  end

  def self.make_phone_number(params)
    pn = params[:user][:phone_number]
    pn  = pn.gsub(/\D/, '')
    return pn
  end

  def self.has_access_code?(user_params)
  ac = AccessCode.where(user_access_code: user_params[:access_code]).pluck(:user_access_code)
  code = ''
   if ac.size > 0
      code = true
  else
      code = false
    end
    return code
  end


  #method to authenticate users
  def self.authenticate(username_or_email="", login_password="")
    chkd = false
    email = self.isEmail(username_or_email)
    if email
      user = self.find_by_email(username_or_email)
      if user && user.encrypted_password == BCrypt::Engine.hash_secret(login_password, user.salt)
        chkd = true
      end
    else
      user = self.find_by_username(username_or_email)
       if user && user.encrypted_password == BCrypt::Engine.hash_secret(login_password, user.salt)
        chkd = true
      end
    end
      return user, chkd
  end

  #method to see if the user exists when the user tries to log in.
  def self.check_authorized_user(authorized_user)
    is_authorized = false
    if authorized_user
      msg = "Welcome again, you logged in as #{authorized_user.username}"
      is_authorized = true
    else
      msg = "Invalid Username or Password"
    end
    return [is_authorized, msg]
  end


    def self.authenticate_security_question(username_or_email="", security_answer="")
      chkd = false
      email = self.isEmail(username_or_email)
      if email
        user = self.find_by_email(username_or_email)
      if user && user.security_answer == BCrypt::Engine.hash_secret(security_answer, user.salt)
        chkd = true
      end
    else
      user = self.find_by_username(username_or_email)
       if user && user.security_answer == BCrypt::Engine.hash_secret(security_answer, user.salt)
        chkd = true
      end
    end
      return user, chkd
  end


  #method to encrypt the user's password
  def encrypt_password()
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end

 def self.encrypt_password_update(password, usersalt)
     encrypted_password = ''
    if password.present?
       encrypted_password= BCrypt::Engine.hash_secret(password, usersalt)
    end
     encrypted_password
  end


  #method to check if the user is entering an email
  def self.isEmail(str)
    return str.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]\.)[a-zA-Z]{2,4}/)
  end

  #method to clear the users password
  def clear_password
    self.password = nil
  end



end
