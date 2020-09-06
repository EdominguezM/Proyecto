class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def my_tweets
    @tweets = Tweet.all.last_tweets.page(params[:page])
  end

  def dashboard
    @users = User.all.page(params[:page])
  end
  
  def show
    
  end

  def edit

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:name, :image_url)
  end
end
