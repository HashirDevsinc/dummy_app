class CommentsController < ApplicationController

	before_action :set_post_comments, only: :create 
	before_action :set_post_comments_comment, except: :create 
	
	def create
		@comment = @post.comments.new(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
	  	respond_to do |format|
				format.js
			end
  	end
	end

	def edit
		respond_to do |format|
			format.js
		end
	end

	def update
		if @comment.update(comment_params)
			@comment = Comment.new
	  	respond_to do |format|
				format.js
			end
		else
	  	flash[:alert] = "failed to update!"
		end
	end

	def destroy
		@comment.destroy
		respond_to do |format|
			format.js
		end
	end

	def report_comment
		@user = current_user
		if @user
			@record = Record.new(comment_id: @comment.id, reporter_id: @user.id)
			if @record.save
				flash[:notice] = "Reported!"
				if @comment.reporters.count == 2
					@comment.destroy
				end
				redirect_to post_path(@post)
			else
				flash[:alert] = "Already reported!"
				redirect_to post_path(@post)
			end
		else
			flash[:alert] = "User does not exist!"
			redirect_to post_path(@post)
		end
	end


	private
  	def comment_params
  		params.require(:comment).permit(:content)
  	end
		def set_post_comments_comment
			@post = Post.find(params[:post_id])
			@comments = @post.comments
			@comment = @post.comments.find(params[:id])
  	end
  	def set_post_comments
  		@post = Post.find(params[:post_id])
			@comments = @post.comments
		end

end
