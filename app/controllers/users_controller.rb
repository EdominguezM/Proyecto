class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def my_tweets
  end

  def dashboard
   
  end
 
end
