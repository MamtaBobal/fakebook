class Like < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
end
