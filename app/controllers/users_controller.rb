class UsersController < ApplicationController
  before_action :authenticate_user!
  def username
    render text: current_user.username
  end
end
