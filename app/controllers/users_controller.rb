class UsersController < ApplicationController

  def show
    @current_user = User.find(params[:id])
  end

  def create
    @user = User.create(params[:user])
    @user.update_credentials(params[:credentials])
    flash[:notice] = "Your account has been successfully created!"
    redirect_to user_path(@user)
  end

  def new
    
  end
end
