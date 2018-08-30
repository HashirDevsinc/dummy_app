Rails.application.routes.draw do

  # get 'friendships/create'
  # get 'friendships/update'
  # get 'friendships/destroy'
  devise_for :users, :controllers => { registrations: 'user/registrations' }
  devise_for :admins
  
  resources :friendships, only: [:create, :update, :destroy]

  resources :posts do
    resources :comments do
      member do
        get :report_comment
      end
    end
    post '/like', to: 'likes#create'
    delete '/unlike', to: 'likes#destroy'
  end
  
  authenticated :admin do
    root to: 'admins/dashboard#home'
    namespace :admins do
      get '/reported_comments', to: 'dashboard#reported_comments'
      get '/deleted_comments', to: 'dashboard#deleted_comments'
      get '/deleted_posts', to: 'dashboard#deleted_posts'
      get '/deleted_users', to: 'dashboard#deleted_users'
      get '/comments/:id', to: 'dashboard#show_comment', as: "comment"
      get '/posts/:id', to: 'dashboard#show_post', as: "post"
      get '/reporters/:id', to: 'dashboard#show_reporter', as: "reporter"
      post '/destroy_comment', to: 'dashboard#destroy_comment', as: "destroy_comment"
      post '/destroy_user', to: 'dashboard#destroy_user', as: "destroy_user"
      get '/users_reported_comments', to: 'dashboard#users_reported_comments'
      get '/graphs', to: 'dashboard#graphs'
    end
  end

  authenticated :user do
    root to: 'static_pages#home'
    get 'profile', to: 'static_pages#profile'
    get 'user_profile', to: 'static_pages#user_profile'
  end

  root to: 'static_pages#home'
  get '/*p', to: redirect('/404')
end