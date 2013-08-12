class User < ActiveRecord::Base
  #dependent: :destroy allows microposts to be deleted if user itself is destroyed
  has_many :microposts, dependent: :destroy

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy

  #rails allowing to override default of followed to followed_users using source
  has_many :followed_users, through: :relationships, source: :followed

  #instead of making another db table for reverse relationships, we will use followed_id
  #as the primary key to go backwards
  has_many :reverse_relationships,  foreign_key:  "followed_id",
                                    class_name:   "Relationship",
                                    dependent:    :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

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

  #checks if user is following other user
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  #creates a follow for user with other user
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  #removes the following for the user with other user
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  private

  #extra indentation is on purpose to make private methods more apparent
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end


end