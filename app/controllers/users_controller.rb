class UsersController < ApplicationController
  before_filter :current_user

  def edit
    if params[:user] != nil and @current_user.update_attributes(params[:user])
      flash[:notice] = "Profile successfully updated."
      redirect_to @current_user
    else
      render 'edit'
    end
  end

  def destroy
    @current_user.destroy
    # Don't like this... I wanted to redirect to sessions#destroy, but redirect_to doesn't do DELETE methods
    session[:user_id] = nil
    redirect_to root_path()
  end

end