# Entity users
class User < ApplicationRecord
  before_save { self.email = email.downcase }
  # validation exist
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:name, presence: true, length: { maximum: 50, minimum: 3 })
  validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    length: { maximum: 25, minimum: 5 },
                    uniqueness: { case_sensitive: false })
  validates(:password, length: { minimum: 6 })
  has_secure_password
end
