class StaticPagesController < ApplicationController
  
  def home
  	if admin_signed_in?
  		render layout: 'admin'
  	elsif user_signed_in?
  		render layout: 'application'
  	end
  end

end
