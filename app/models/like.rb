# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  post_id    :bigint
#  comment_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
end
