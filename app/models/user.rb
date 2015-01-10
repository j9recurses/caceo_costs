
class User < ActiveRecord::Base
  has_many :role_assignments
  has_many :roles, through: :role_assignments
  belongs_to :county, class_name: 'CaCountyInfo', foreign_key: 'county_id', inverse_of: :users
  attr_accessor :password
  before_save :encrypt_password
  after_save :clear_password
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 4..20 }
  validates :email, :presence => true, :uniqueness => true,   :email => true
  validates :county_id, :presence => true
  validates :password, :confirmation => true #password_confirmation attr
  validates_presence_of :password, :on => :create
  validates_length_of :password, :in => 5..20, :on => :create
  validates :security_question, :security_answer, :presence => true, :on => :update
  validates :fn, :ln, :dob, :presence => true , :if => :active_or_personal?

  def observer?
    role_names.include?('observer')
  end

  def admin?
    role_names.include?('admin')
  end

  def role_names
    @role_names ||= roles.pluck(:name)
  end

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
    if !(user_params[:access_code] && user_params[:county_id])
      false
    else
      code = AccessCode.find_by( user_access_code: user_params[:access_code] )
      if ( code && ( code.county_id.to_s == user_params[:county_id] ) )
        true
      else
        false
      end
    end
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

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
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
    str.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    # return str.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]\.)[a-zA-Z]{2,4}/)
  end

  #method to clear the users password
  def clear_password
    self.password = nil
  end



end
