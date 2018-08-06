class CommentsController < ApplicationController
	
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
	  	flash[:notice] = "Comment has been added!"
	  	redirect_to post_path(@post)
  	end
	end


	private
  	def comment_params
  		params.require(:comment).permit(:content)
  	end
end
