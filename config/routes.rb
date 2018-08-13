Rails.application.routes.draw do

  devise_for :users
  devise_for :admins
  
  resources :posts do
    resources :comments do
      member do
        get :report_comment
      end
    end
  end
  
  authenticated :admin do
    root to: 'admins/dashboard#home'
    namespace :admins do
      get '/show', to: 'dashboard#show'
      get '/show_deleted', to: 'dashboard#show_deleted'

      get '/comments/:id', to: 'dashboard#show_comment', as: "comment"
      get '/posts/:id', to: 'dashboard#show_post', as: "post"
      get '/reporters/:id', to: 'dashboard#show_reporter', as: "reporter"    
    end
  end

  authenticated :user do
    root to: 'static_pages#home'
  end

  root to: 'static_pages#home'
  get '/*p', to: redirect('/404')
end
