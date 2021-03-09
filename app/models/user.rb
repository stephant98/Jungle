class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true

  before_save :email_downcase


  def email_downcase
    self.email.downcase!
  end


  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
  
end
