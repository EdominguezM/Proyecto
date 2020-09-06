class FollowsController < ApplicationController
  before_action :find_tweet
  before_action :find_follow, only: [:destroy]

  def index
    #@q = Tweet.tweets_for_me(current_user.followers).ransack(params[:q])
    if user_signed_in?
      @q = Tweet.tweets_for_me(current_user.followers).ransack(params[:q])
      @tweets = @q.result(distinct: true).page(params[:page])
    else
      redirect_to tweets_path
      #@tweets = Tweet.all.last_tweets.page(params[:page])
    end
    #tweets_for_me(current_user.followers).page(params[:page])
  end

  def create
    if already_follow?
      flash[:notice] = "no puede seguirlo nuevamente"
    else
      @user = Follow.create(follow_params)
    end
    redirect_to root_path
  end

  def destroy
    if !(already_follow?)
      flash[:notice] = "siguiendo"
    else
      @follow.destroy
    end
    redirect_to root_path
  end

  def find_follow
    @follow = Follow.find_by(follow_params)
  end 

  private

  def find_tweet
    @tweet = Tweet.find_by(params[:tweet_id])
  end 

  def already_follow?
    Follow.where(follow_params).exists?
  end
  
  def follow_params
    params.permit(:follower_id, :following_id, 
      tweet_attributes: [:user_id, :tweet_id])
  end
end
