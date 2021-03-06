class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    tweet = Tweet.find params[:id]
    comment = tweet.comments.build(content: params[:comment], user: current_user)
    if comment.save
      render json: {}
    else
      render json: {error_message: comment.errors.full_messages}, status: 400
    end
  end

  def index
    tweet = Tweet.find params[:tweet_id]
    render json: tweet.comments.map(&Tweet.comment_block)
  end

  def create_sub
    comment = Comment.find params[:comment_id]
    comment.sub_comments.create(content: params[:content], user: current_user)
    render json: {}
  end
end
