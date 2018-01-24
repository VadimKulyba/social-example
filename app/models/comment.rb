class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  validates :body, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :micropost_id, presence: true
end
