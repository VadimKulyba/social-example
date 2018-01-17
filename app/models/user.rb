# Entity users
class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #:database_authenticatable, :registerable,
  #      :recoverable, :rememberable, :trackable, :validatable,
  devise :omniauthable, :omniauth_providers => [:vkontakte]

  # validation exist
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:name, presence: true, length: { maximum: 50, minimum: 3 })
  validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false })

  validates(:password, length: { minimum: 6 })
  has_secure_password

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

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
