class SessionsController < ApplicationController

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
        redirect_to user_path(@user, :user => @user) and return

      else

        flash[:notice] = "User does not exist"
        redirect_to root_path() and return

      end
    end
    redirect_to root_path() and return
  end
 
  def signout
    session[:user_id] = nil
  end 
end
