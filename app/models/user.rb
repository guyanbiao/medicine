class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :username,           type: String, default: ""
  field :avatar,           type: String, default: ""
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :provider, type: String
  field :uid, type: String

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  #custom filed --->
  field :authentication_token
  before_save :ensure_authentication_token

  has_many :meals



  def password_required?
      super && provider.blank?
  end

  def email_required?
      super && provider.blank?
  end

  private
  def ensure_authentication_token
    if self.authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def reset_authentication_token!
      self.authentication_token = generate_authentication_token
      self.save
  end
end
