class CommentsController < ApplicationController
  def create
    tweet = Tweet.find params[:id]
    tweet.comments.create(content: params[:comment])
    render json: {}
  end

  def index
    tweet = Tweet.find params[:tweet_id]
    render json: tweet.comments.map(&:content)
  end
end
