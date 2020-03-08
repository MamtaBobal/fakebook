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
end
