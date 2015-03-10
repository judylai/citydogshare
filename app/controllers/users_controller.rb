class UsersController < ApplicationController

  def show
    @current_user = User.find(params[:id])
  end

  def create
  	current_user = User.new
  	
  	current_user.uid = session[:user_id]
  	current_user.first_name = session[:user_info][:first_name]
  	current_user.last_name = session[:user_info][:last_name]
  	current_user.oauth_token = session[:user_info][:oauth_token]
  	current_user.oauth_expires_at =session[:user_info][:oauth_expires_at]
  	current_user.image = session[:user_info][:image]
  	current_user.email = session[:user_info][:email]
  	current_user.location = params[:user][:location]
  	current_user.gender = params[:user][:gender]
  	current_user.status = params[:user][:status]
  	current_user.phone_number = params[:user][:phone_number]
  	current_user.availability = params[:user][:availability]
  	current_user.description = params[:user][:description]

  	current_user.save!

    flash[:notice] = "User created"
    redirect_to root_path()
  end

  def new
  end
end
