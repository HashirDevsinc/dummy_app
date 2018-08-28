class Admins::DashboardController < Admins::BaseController

	def home
  	@users = User.all
	end

	def reported_comments
		@comments = Comment.reported_comments
	end

	def deleted_comments
  	@deleted_comments = Comment.only_deleted
	end

	def deleted_posts
  	@deleted_posts = Post.only_deleted
	end

	def deleted_users
  	@deleted_users = User.where.not(deleted_at: nil)
	end
	
	def show_comment
		@comment = Comment.find(params[:id])
		@post = @comment.post
	end
	
	def show_post
		@post = Post.find(params[:id])
	end
	
	def show_reporter
		@reporter = User.find(params[:id])
	end

	def destroy_comment
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to root_path
	end

	def destroy_user
		@user = User.find(params[:id])
    @user.update_attribute(:deleted_at, Time.current)
    @posts = Post.where(user_id: @user.id)
    @posts.each do |post|
      post.destroy
    end 
    redirect_to root_path
	end

	def users_reported_comments
  	@users = User.all
	end

	def graphs
	end
end
