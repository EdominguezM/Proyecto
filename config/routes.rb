Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  class ActiveAdmin::Devise::SessionsController
    def after_sign_in_path_for(resource)
      case resource
        when AdminUser then '/admin'
          else super
        end 
      end
    def after_sign_out_path_for(resource)
      '/admin'
    end
  end
  root 'follows#index'
  get '/following', to: 'follows#following', as: :following
  get '/tweets search:q', to: "tweets#tweets_search",as: :search
  
  get '/api/news', to: 'tweets#news'
  get '/api/:from/:to', to:'tweets#dates'
  post '/api/tweets', to: 'tweets#api_create'

  resources :tweets do
    resources :likes
    resources :retweets
  end
  
 post 'tweet/:follower_id/follows/:following_id', to: 'follows#create', as: :create
 delete 'tweet/:follower_id/follows/:following_id', to: 'follows#destroy', as: :destroy
 
  devise_for :users, controllers:{ registrations:'users/registrations'}

  namespace :api, defaults: {format: :json} do  
      devise_scope :user do
        namespace :v1 do
          post "sign_in", to: "sessions#create"
        end
      end
  end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
