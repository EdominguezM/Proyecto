class LikesController < ApplicationController
  before_action :find_tweet
  before_action :find_like, only: [:destroy]

  def index
    @likes = Like.all
    
  end

  

  # GET /like/new
  def new
    @like = Like.new
  end



  def create
    if already_liked?
      flash[:notice] = "no puedes dar mas de un Like"
    else
      @tweet.likes.create(user_id: current_user.id)
    end
    redirect_to tweet_path(@tweet)  
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "no me gusta"
    else
      @like.destroy
    end
    redirect_to tweet_path(@tweet)
  end

  def find_like
    @like = @tweet.likes.find(params[:id])
  end

  private
   # Use callbacks to share common setup or constraints between actions.
   def find_tweet
     @tweet = Tweet.find(params[:tweet_id])
   end 

   def already_liked?
    Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
   end

  # Only allow a list of trusted parameters through.
  def like_params
    params.permit(:active, :user_id, :tweet_id)
  end
end
