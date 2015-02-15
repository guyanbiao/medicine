class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate_user_from_token!
  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user = user_token && User.find_by(authentication_token: user_token.to_s)
    if user
      sign_in user, store: false
    end
  end
end
