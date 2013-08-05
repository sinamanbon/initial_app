class Micropost < ActiveRecord::Base
  belongs_to :user

  #ordering by descending
  default_scope -> { order ('created_at DESC') }

  validates :user_id, presence: true
end
