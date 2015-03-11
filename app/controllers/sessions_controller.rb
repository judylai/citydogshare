class SessionsController < ApplicationController


  def create 
    session[:user_id] = params[:uid]
    redirect_to user_path(params[:user])
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path()
  end 

  def handle_failure
    flash[:notice] = "Something went wrong with the authentication. Please try again."
    redirect_to root_path()
  end

  def handle_auth 

    uid = request.env["omniauth.auth"][:uid]
    @user = User.find_by_uid(uid)

    # Get large version of profile picture
    request.env["omniauth.auth"][:info][:image] = request.env["omniauth.auth"][:info][:image][0..-7] + "large"

    if request.env["omniauth.params"]["type"] == "login"

      if @user
        @user.update_credentials(request.env["omniauth.auth"][:credentials])
        redirect_to :controller => 'sessions', :action => 'create', :user => @user, :uid => @user.uid
      else
        flash[:notice] = "User does not exist. Please sign up."
        redirect_to root_path()
      end

    elsif request.env["omniauth.params"]["type"] == "signup"

      if @user
        flash[:notice] = "A user already exists with this facebook account."
        redirect_to root_path()
      else
        redirect_to :controller => 'users', :action => 'new', :user_info => request.env["omniauth.auth"]
      end
    end
  end
 
end
