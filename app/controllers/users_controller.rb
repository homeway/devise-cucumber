class UsersController < ApplicationController
  #before_filter :authenticate_user!
  def list
    @users = User.all
  end
end
