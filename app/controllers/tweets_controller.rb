class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: Tweet.all.map {|t|{content: t.content, id: t.id.to_s, comments: t.comments.map(&:content)}}
  end

  def create
    current_user.tweets.create tweet_params
    render json: {}
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
