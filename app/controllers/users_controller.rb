class UsersController < ApplicationController

  def show
    @current_user = User.find(params[:id])
  end

  def create
  end

  def new
  end
end
