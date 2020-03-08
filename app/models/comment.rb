# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text
#  user_id    :bigint
#  post_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post
  has_many :likes, dependent: :destroy
end
