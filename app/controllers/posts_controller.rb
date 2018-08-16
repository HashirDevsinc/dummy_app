class PostsController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@posts = Post.includes(:user).where(users: {deleted_at: nil})
		# @users_cust = User.joins(:posts).where(posts: {id: [1,2,5]})
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.new(post_params)
  	if @post.save
  		flash[:notice] = "Your post has been created!"
  		redirect_to posts_path
  	else
  		render 'new'
  	end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
		# @comments = @post.comments.includes(:user).where(users: {deleted_at: nil})
		# @commented_users = User.joins(:comments).where(comments: {post_id: @post.id})

		@comment = Comment.new		
	end

	private
  	def post_params
  		params.require(:post).permit(:title, :body, images_attributes: [:id, :picture, :_destroy])
  	end
end
