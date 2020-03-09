class FriendshipsController < ApplicationController
	include ApplicationHelper

  def create
		# Disallow the ability to send yourself a friend request
		return if current_user.id == params[:user_id]
		# Disallow the ability to send friend request more than once to same person
		return if friend_request_sent?(User.find(params[:user_id]))
		# Disallow the ability to receive friend request from someone who already sent you one
		return if friend_request_received?(User.find(params[:user_id]))

		@user = User.find(params[:user_id])
		@friendship = current_user.friend_sent.build(sent_to_id: params[:user_id], status: false)
		if @friendship.save
			flash[:success] = 'Friend Request Sent!'
			@notification = new_notification(@user, @current_user.id, 'friendRequest')
			@notification.save
		else
			flash[:danger] = 'Friend Request Failed!'
		end
		redirect_back(fallback_location: root_path)
  end

  def accept_friend
		@friendship = Friendship.find_by(sent_to_id: current_user.id, sent_by_id: params[:user_id], status: false)
		return unless @friendship
		@friendship.status = true
		if @friendship.save
			flash[:success] = 'Friend Request Accepted!'
			@friendship2 = current_user.friend_sent.build(sent_to_id: params[:user_id], status: true)
			@friendship2.save
		else
			flash[:danger] = 'Friend Request could not be accepted'
		end
		redirect_back(fallback_location: root_path)
  end

  def decline_friend
		@friendship = Friendship.find_by(sent_to_id: current_user.id, sent_by_id: params[:user_id], status: false)
		return unless @friendship
		@friendship.destroy
		flash[:success] = 'Friend Request Declined!'
		redirect_back(fallback_location: root_path)
  end
end
