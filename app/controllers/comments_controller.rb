class CommentsController < ApplicationController
	include ApplicationHelper

  def new
		@comment = Comment.new
  end

  def create
		@comment = current_user.comments.build(comments_params)
		@post = Post.find(params[:comment][:post_id])
		if @comment.save!
			@notification = new_notification(@post.user, @post.id,
			 'comment')
			@notification.save!
		end
		redirect_to @post
  end

  def destroy
		@comment = Comment.find(params[:id])
		@post = @comment.post
		# User can destroy his/her own comments only
		return unless current_user.id == @comment.user_id
		if @comment.destroy
			flash[:success] = 'Comment deleted'
			# redirects the browser back to the root_path
			redirect_back(fallback_location: root_path)
		else
			redirect_to @comment
		end
  end

  private
  def comments_params
		params.require(:comment).permit(:content, :post_id)
  end
end
