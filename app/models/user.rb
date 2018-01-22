# Entity users
class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_relationships, foreign_key: 'followed_id',
                                   class_name: 'Relationship',
                                   dependent: :destroy
  # methods get
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #:database_authenticatable, :registerable,
  #      :recoverable, :rememberable, :trackable, :validatable,
  devise :omniauthable, omniauth_providers: [:vkontakte]

  # validation exist
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:name, presence: true, length: { maximum: 50, minimum: 3 })
  validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false })

  validates(:password, length: { minimum: 6 })
  has_secure_password

  # micropost methods (wall for any users)
  def wall
    Micropost.from_users_followed_by(self)
  end

  # relationship
  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy!
  end

  # for session
  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # for vk authorize
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.uid + '@vk.ru'
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
