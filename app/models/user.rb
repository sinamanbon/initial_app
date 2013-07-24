class User < ActiveRecord::Base
  #forcing email to be downcased
  before_save { self.email = email.downcase}

  #validates just presence of :name and :email
  #validates_presence_of :name, :email

  #validation of :name only
  validates :name, presence: true, length: {maximum: 50}


  #validation of :email only
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format:{with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, length: { minimum: 6 }


end
