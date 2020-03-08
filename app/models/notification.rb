# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  notice_id   :integer
#  notice_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Notification < ApplicationRecord
  # Associations
  belongs_to :user

  # Scopes
  scope :friend_requests, -> { where('notice_type = Friendship') }
  scope :comments, -> { where('notice_type = Comment') }
  scope :likes, -> { where('notice_type = Like') }
end
