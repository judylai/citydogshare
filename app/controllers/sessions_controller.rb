class SessionsController < ApplicationController

  def handle_login  
    session[:fb] = "login"
    redirect_to '/auth/facebook'
  end

  def handle_auth
    session[:fb] = "logginn"
    uid = request.env["omniauth.auth"][:uid]
    @user = User.find_by_uid(uid)
    render 'sessions/create.html.erb'
  end
      
end
