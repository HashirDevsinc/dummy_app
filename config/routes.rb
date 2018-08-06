Rails.application.routes.draw do

  devise_for :users

  resources :posts do
  	resources :comments
  end
	
	root to: 'static_pages#home'

end
