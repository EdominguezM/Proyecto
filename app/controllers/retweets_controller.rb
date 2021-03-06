class RetweetsController < ApplicationController
  before_action :find_tweet
  before_action :find_retweet, only: [:show, :destroy]

  def index
  end

  def new
    @retweet = Retweet.new
  end

  def create
    @retweet =  @tweet.retweets.create(user_id: current_user.id)
    @retweet.tweet.retweets_count += 1
    @retweet.tweet.save
    if @retweet.save
      redirect_to  tweet_retweet_path(@tweet.id, @retweet.id) 
    end
    
  end

  def show
    @retweet = @tweet.retweets.find(params[:id])
  end

  def destroy

    
  end

  private
 
  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def find_retweet
    @retweet = @tweet.retweets.find(params[:id])
  end
  
  def set_retweet
    @retweet = Retweet.find(params[:id])
  end

 
  def retweet_params
    params.permit(:active, :user_id, :tweet_id)
  end
end
