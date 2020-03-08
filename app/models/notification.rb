class Notification < ApplicationRecord
  # Associations
  belongs_to :user

  # Scopes
  scope :friend_requests, -> { where('notice_type = Friendship') }
  scope :comments, -> { where('notice_type = Comment') }
  scope :likes, -> { where('notice_type = Like') }
end
