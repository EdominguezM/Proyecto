class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,  only: [:create, :show, :edit, :update, :destroy]
  before_action :tweet_params,  except: [:create]
 
  def index
    if user_signed_in?
      @q = Tweet.last_tweets.ransack(params[:q])
      @tweets = @q.result(distinct: true).page(params[:page])
    else
      @tweets = Tweet.last_tweets.page(params[:page])
    end
  end

  def show
    @pre_like = @tweet.likes.find { |like| like.user_id == current_user.id}
    @pre_follow = Follow.where(follower_id: @tweet.user_id, following_id: current_user.id).exists?
   
  end

  def new
    @tweet = Tweet.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def create
    @tweet = Tweet.new(tweet_params)
   
    @tweet.user = current_user
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to tweets_path, notice: 'El Tweet fue exitosamente creado.' }
      else
        format.html { render :new }
      end
      if @tweet.save
        format.json { render json: @tweet.to_json( :only => [:id, :content]) }
      else  
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
    respond_to do |format|
      if @tweet.update(update_params)
        format.html { redirect_to @tweet, notice: 'El Tweet fue actualizado.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'El Tweet fue destruido.' }
      format.json { head :no_content }
    end
  end

  def tweets_search
    @tweets = Tweet.last_tweets.where("content LIKE ?", "%" + params[:q] + "%")
  end

  def api_create
    @tweet = Tweet.new(api_params)
   
    @tweet.user = current_user
    respond_to do |format|
      if @tweet.save
        format.json { render json: @tweet.to_json( :only => [:id, :content]) }
      else  
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def dates
    @date =  Tweet.dates_tweets(params[:from], params[:to ])
   
    respond_to do |format|
      if @date != []
          format.json {  render :json => @date.to_json }   
      
      else
          format.json { render json: "sin datos en esta fecha", status: :unprocessable_entity }
      end
    end
  end

  def news
    @api = Tweet.last(50)

   respond_to do |format|
    format.json {  render :json => @api.to_json( :only => [:id, :content, :user_id, :likes_count, :retweets_count]) }
   end
  end

  private
  
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def update_params
      params.require(:tweet).permit(:content,:user_id, 
        like_attributes: [:tweet_id, :active, :user_id],
        retweet_attributes: [:tweet_id, :active, :user_id])
    end

    def tweet_params
      params.permit(:content, :likes_count, :retweets_count, :user_id,:from, :to, :user_email, :user_token, :q,
        like_attributes: [:tweet_id, :active, :user_id],
        retweet_attributes: [:tweet_id, :active, :user_id],
        follow_attributes: [:follower_id, :following_id])
    end

    def api_params
      params.require(:tweet).permit(:content, :likes_count, :retweets_count, :user_id,:from, :to, :user_email, :user_token,
        like_attributes: [:tweet_id, :active, :user_id],
        retweet_attributes: [:tweet_id, :active, :user_id],
        follow_attributes: [:follower_id, :following_id])
    end
end
