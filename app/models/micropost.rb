class Micropost < ActiveRecord::Base
  belongs_to :user

  #ordering by descending
  default_scope -> { order ('created_at DESC') }

  #validates the content row for presence and setting maximum length
  validates :content, presence:true, length: { maximum: 140}

  validates :user_id, presence: true
end
