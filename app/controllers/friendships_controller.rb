class FriendshipsController < ApplicationController
  def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id])
	  if @friendship.save
	    flash[:notice] = "Friend request sent!"
	    redirect_to profile_path(current_user)
	  else
	    flash[:error] = "Unable to request friendship."
	    redirect_to profile_path(current_user)
	  end
  end

  def update
  	@friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
		@friendship.update(accepted: true)
	  if @friendship.save
	    redirect_to profile_path(current_user), notice: "Friend Request Approved!"
	  else
	    redirect_to profile_path(current_user), notice: "Sorry! Could not confirm friend!"
	  end
  end

  def destroy
  	@friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
	  @friendship.destroy
	  flash[:notice] = "Request Declined."
	  redirect_to profile_path(current_user)
  end
end