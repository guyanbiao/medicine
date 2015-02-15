class TweetsController < ApplicationController
  def index
    render json: ["sandy 好诱惑", "711打折啦", "你们这群篮球菜鸟，马甸公园不服来战", "一股脑残波喷死你"]
  end

  def create
    Tweet.new tweet_params
    render json: {}
  end

  def tweet_params
    params[:tweet].permit(:content)
  end
end
