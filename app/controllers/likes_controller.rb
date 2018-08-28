class LikesController < ApplicationController
	before_action :set_post 
	
	def create
		@likes = @post.likes
		@like = @post.likes.new
		@like.user_id = current_user.id
		if @like.save
			@already_liked = Like.find_by(post_id: @post.id, user_id: current_user.id)
	  	respond_to do |format|
				format.js
			end
  	end
	end

	def destroy
		@like = Like.find_by(post_id: @post.id, user_id: current_user.id)
		@like.destroy
		@already_liked = Like.find_by(post_id: @post.id, user_id: current_user.id)
		@likes = @post.likes
		respond_to do |format|
			format.js
		end
	end

	private
		def set_post
  		@post = Post.find(params[:post_id])
		end
end
