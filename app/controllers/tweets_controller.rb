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
      begin
          if params[:page_num]
              page_num = Integer(params[:page_num])
          else
              page_num = 1
          end
      rescue
          page_num = 1
      end
    render json: {result: Tweet.page(page_num).per(per_page).map(&Tweet.tweet_block), is_has_more: (Tweet.count > page_num*per_page)}
  end

  def create
    current_user.tweets.create tweet_params
    render json: {}
  end

  def vote
    tweet = Tweet.find params[:id]
    #顶或者踩之后不能更改
    tweet.update_attributes(feedback: params[:feedback])
  end

  def tweet_params
    params.require(:tweet).permit(:content, :location => [])
  end

  private
  def per_page
    20
  end
end
