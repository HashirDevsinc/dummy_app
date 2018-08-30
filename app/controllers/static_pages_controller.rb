class StaticPagesController < ApplicationController
  
  def home
  	if admin_signed_in?
  		render layout: 'admin'
  	elsif user_signed_in?
  		render layout: 'application'
  	end
  end

  def profile
		@friends1 = Friendship.where(user_id: current_user.id).pluck(:friend_id)
		@friends2 = Friendship.where(friend_id: current_user.id).pluck(:user_id)
		@friends = @friends1 + @friends2
		@friends << current_user.id
  	@users = User.where.not(id: @friends).where(deleted_at: nil)
  end
  def user_profile
		@user = User.find(params[:id])
 		@friends = Friendship.where(user_id: @user.id, friend_id: current_user.id).or(Friendship.where(user_id: current_user.id, friend_id: @user.id))
  end
end