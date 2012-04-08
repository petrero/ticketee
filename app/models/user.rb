class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :permissions
  has_many :comments
  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
  
  before_save :ensure_authentication_token
  
  def self.reset_request_count!
    update_all("request_count = 0", "request_count > 0")
  end
end
