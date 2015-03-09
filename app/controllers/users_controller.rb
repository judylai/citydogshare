class UsersController < ApplicationController

  def show
    @current_user = User.find(params[:user])
  end

  def create
  end
end
