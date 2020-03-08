class PostsController < ApplicationController
	before_action :set_post, only: %i[show]
  def index
		@our_posts = current_user.friends_and_own_posts
  end

  def show
  end

  def new
		@post = Post.new
  end

  def create
		@post = current_user.posts.build(posts_params)
		if @post.save!
			redirect_to @post
		else
			render 'new'
		end
  end

  def destroy; end

  private

  def set_post
		@post = Post.find(params[:id])
  end

  def posts_params
		params.require(:post).permit(:user_id, :content)
  end
end
