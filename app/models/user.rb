# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  fname                  :string
#  lname                  :string
#  image                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_sent, class_name: 'Friendship', foreign_key: 'sent_by_id',
   inverse_of: 'sent_by', dependent: :destroy
  has_many :friend_request, class_name: 'Friendship', foreign_key: 'sent_to_id',
   inverse_of: 'sent_to', dependent: :destroy
  has_many :friends, -> { merge(Friendship.friends) }, through: :friend_sent, source: :sent_to
  has_many :pending_requests, -> { merge(Friendship.not_friends) }, through: :friend_sent,
   source: :sent_to
  has_many :received_requests, -> { merge(Friendship.not_friends) }, through: :friend_request,
  source: :sent_by
  has_many :notifications, dependent: :destroy

  # Returns a string containing this user's first name and last name
  def full_name
    "#{fname} #{lname}"
  end

  # Returns all posts from this user's friends and self
  def friends_and_own_posts
    my_friends = friends
    our_posts = []
    my_friends.each do |friend|
      friend.posts.each do |post|
        our_posts << post
      end
    end
    posts.each do |post|
      our_posts << post
    end
    our_posts
  end

end
