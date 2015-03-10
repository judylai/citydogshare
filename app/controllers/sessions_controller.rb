class SessionsController < ApplicationController

  def handle_failure
    flash[:notice] = "Something went wrong with the authentication. Please try again."
    redirect_to root_path() and return
  end

  def handle_auth 

    uid = request.env["omniauth.auth"][:uid]
    @user = User.find_by_uid(uid)

    if request.env["omniauth.params"]["type"] == "login"

      if @user
        @user.oauth_token = request.env["omniauth.auth"][:credentials][:token]
        @user.oauth_expires_at= request.env["omniauth.auth"][:credentials][:expires_at]
        @user.uid = request.env["omniauth.auth"][:uid]
        @user.save

        session[:user_id] = request.env["omniauth.auth"][:uid]
        redirect_to user_path(@user) and return

      else

        flash[:notice] = "User does not exist"
        redirect_to root_path() and return

      end
    elsif request.env["omniauth.params"]["type"] == "signup"

      if @user
        @user.oauth_token = request.env["omniauth.auth"][:credentials][:token]
        @user.oauth_expires_at= request.env["omniauth.auth"][:credentials][:expires_at]
        @user.uid = request.env["omniauth.auth"][:uid]
        #@user.save

        session[:user_id] = request.env["omniauth.auth"][:uid]

        flash[:notice] = "A user already exists with this facebook account."
        redirect_to user_path(@user) and return
      else
        session[:user_id] = request.env["omniauth.auth"][:uid]
        session[:user_info] = request.env["omniauth.auth"][:info]
        redirect_to '/users/new' and return
      end
    end
    redirect_to root_path() and return
  end
 
  def destroy
    session[:user_id] = nil
    redirect_to root_path() and return
  end 
end
