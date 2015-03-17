class TweetsController < ApplicationController
  before_action :authenticate_user!
  def show
    tweet = Tweet.find params[:id]
    page_num = params[:page_num] || 1
    comments = tweet.comments.page(1).per(per_page).map &Tweet.comment_block
    render json: Tweet.tweet_block.call(tweet)
    .merge({comments: comments})
  end

  def index
    page_num = params[:page_num] || 1
    render json: Tweet.page(page_num).per(per_page).map(&Tweet.tweet_block)
  end

  def create
    current_user.tweets.create tweet_params
    render json: {}
  end

  def vote
  end

  def tweet_params
    params.require(:tweet).permit(:content, :location => [])
  end

  private
  def per_page
    20
  end
end
