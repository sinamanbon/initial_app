class User < ActiveRecord::Base
  #dependent: :destroy allows microposts to be deleted if user itself is destroyed
  has_many :microposts, dependent: :destroy
  has_secure_password
  #forcing email to be downcased
  before_save { self.email = email.downcase}
  before_create :create_remember_token

  #validates just presence of :name and :email
  #validates_presence_of :name, :email

  #validation of :name only
  validates :name, presence: true, length: {maximum: 50}

  #validation of :email only
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format:{with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    #urlsafe_base64 is a random string of 16 characters composed of 64 possibility
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    #faster hashing algorithm and less secure than bcrypt - sufficient b/c its passing from urlsafe_base64
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    #This is preliminary. See "Following users" for the full implementation
    Micropost.where("user_id = ?", id)
  end

  private

  #extra indentation is on purpose to make private methods more apparent
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end


end