Rails.application.routes.draw do
  #get 'retweets/new'
  #get 'retweets/create'
  #get 'retweets/destroy'
  #get 'likes/new'
  #post 'likes/create'
 # get 'likes/destroy'
  resources :tweets
  resources :tweets do
    resources :likes
    resources :retweets
  end
 
  #get 'home/index'
  #get 'users/my_tweets'
  #get 'users/dashboard'
  devise_for :users, controllers:{ registrations:'users/registrations'}
 
  root 'tweets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
