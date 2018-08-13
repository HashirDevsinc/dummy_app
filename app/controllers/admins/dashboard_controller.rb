class Admins::DashboardController < Admins::BaseController
	# before_action :authenticate_admin!

	# layout "admin"
	
	def home
  	@comments = Comment.all
	end

	def show
	end

	def show_deleted
  	@deleted_comments = Comment.only_deleted
  	@deleted_posts = Post.only_deleted
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

end
