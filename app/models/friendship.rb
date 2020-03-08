# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  sent_to_id :integer
#  sent_by_id :integer
#  status     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friendship < ApplicationRecord
	# Associations
	belongs_to :sent_to, class_name: 'User', foreign_key: 'sent_to_id'
	belongs_to :sent_by, class_name: 'User', foreign_key: 'sent_by_id'

	# Scopes
	scope :friends, -> { where('status =?', true) }
	scope :not_friends, -> { where('status =?', false) }
end
