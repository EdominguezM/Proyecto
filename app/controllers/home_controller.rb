class HomeController < ApplicationController

  def index
    @q = Tweet.last_tweets.page(params[:page]).ransack(params[:q])  
    @tweets = @q.result(distinct: true)
  end
end
