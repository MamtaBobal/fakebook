module ApplicationHelper
	# Create Notification
	def new_notification(user, notice_id, notice_type)
		notice = user.notifications.build(notice_id: notice_id,
		 notice_type: notice_type)
		notice
	end

	# Receives the notification object as parameter
	def notification_find(notice)
		# Pending
	end

	# Checks whether a post or a comment has already been liked by the
	 # current user returning either true or false
		def liked?(subject, type)
			result = false
			result = Like.where(user_id: current_user.id, post_id: subject.id).exists? if type == 'post'
			result = Like.where(user_id: current_user.id, comment_id: subject.id).exists? if type == 'comment'
			result
		end

	def friend_request_sent?(user)
		current_user.friend_sent.exists?(sent_to_id: user.id, status: false)
	end

	def friend_request_received?(user)
		current_user.friend_request.exists?(sent_by_id: user.id, status: false)
	end

	def possible_friend?(user)
		request_sent = current_user.friend_sent.exists?(sent_to_id: user.id)
		request_received = current_user.friend_request.exists?(sent_by_id: user.id)

		return true if request_sent != request_received
		return true if request_sent == request_received if request_sent == true
		return false if request_sent == request_received if request_sent == false
	end

end
