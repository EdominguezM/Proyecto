Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'tweets?search=', to: "tweets#tweets_search", as: :tweets_search
  #post 'tweets/tweets_search', to: "tweets#search"
  
 
  resources :tweets do
    resources :likes
    resources :retweets
  end
  
  
 post 'tweet/:follower_id/follows/:following_id', to: 'follows#create', as: :create
 delete 'tweet/:follower_id/follows/:following_id', to: 'follows#destroy', as: :destroy

 #resources :users
  #get 'home/index'
  #get 'users/my_tweets'
  #get 'users/dashboard'
  #get 'users/show '

  devise_for :users, controllers:{ registrations:'users/registrations'}
  
  root 'follows#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
