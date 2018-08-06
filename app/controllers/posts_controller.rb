class PostsController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@posts = Post.all
		puts "=================================================================================================="
		puts "=================================================================================================="
		puts "=================================================================================================="
		# @users_cust = User.includes(:posts).where(posts: {id: [1,2,5]})
		@users_cust = User.joins(:posts).where(posts: {id: [1,2,5]})
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

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
		puts "=================================================================================================="
		puts "=================================================================================================="
		puts "=================================================================================================="
		# @commented_users = User.includes(:comments).where(comments: {post_id: 1})
		@commented_users = User.joins(:comments).where(comments: {post_id: @post.id})
	end

	private
  	def post_params
  		params.require(:post).permit(:title, :body)
  	end
end
