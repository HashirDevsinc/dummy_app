class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	
	layout :layout_by_resource


  protected
	  def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:image_attributes => [:id, :picture, :_destroy]])
	  end
	  
	  def layout_by_resource
	    if devise_controller? && resource_name == :admin
	      "admin"
	    else
	      "application"
	    end
	  end
end
