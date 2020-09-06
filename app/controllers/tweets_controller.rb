class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    if user_signed_in?
      @q = Tweet.last_tweets.ransack(params[:q])
      @tweets = @q.result(distinct: true).page(params[:page])
    else
      @tweets = Tweet.last_tweets.page(params[:page])
    end
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @pre_like = @tweet.likes.find { |like| like.user_id == current_user.id}
    @pre_follow = Follow.where(follower_id: @tweet.user_id, following_id: current_user.id).exists?
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
    @tweet = Tweet.find(params[:id])
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
   
    @tweet.user = current_user
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to tweets_path, notice: 'El Tweet fue exitosamente creado.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
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

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'El Tweet fue destruido.' }
      format.json { head :no_content }
    end
  end



  def tweets_search
    index
    render  :index
    #@q = Tweet.search(params[:q])
    #@tweets = @q.result(distinct: true).page(params[:page])
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def update_params
      params.require(:tweet).permit(:content,:user_id, 
        like_attributes: [:tweet_id, :active, :user_id],
        retweet_attributes: [:tweet_id, :active, :user_id])
    end
    
    # Only allow a list of trusted parameters through.
    def tweet_params
      params.permit(:content, :likes_count, :retweets_count, :user_id, 
        like_attributes: [:tweet_id, :active, :user_id],
        retweet_attributes: [:tweet_id, :active, :user_id],
        follow_attributes: [:follower_id, :following_id])
    end
end
