require 'spec_helper'

describe SessionsController, :type => :controller do
  describe 'logging in as an existing user' do
    it 'should store the correct login flag in the sessions hash' do
      get :login
      session[:fb].should == "login" 
    end
    it 'should call the find by uid user model method' do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
      User.should_receive(:find_by_uid).with(request.env["omniauth.auth"][:uid])
      visit "/auth/facebook"
    end 
    it 'should call the update user model method' do
      user1 = FactoryGirl.create(:user, :uid => 12345, :id => 1)
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
      user1.should_receive(:auth_update).with(request.env["omniauth.auth"])
      get :handle_login
    end 
    it 'should add the user id to the sessions hash' do 
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
      get :handle_login
      session[:user_id].should == request.env["omniauth.auth"][:uid]
    end
    it 'should select the home page for rendering' do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
      get :handle_login
      response.should render_template('/')
    end
    it 'should make the user name available for display' do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
      fake_result = double('user1')
      User.should_receive(:find_by_uid).with(request.env["omniauth.auth"]["uid"]).and_return(fake_result)
      get :handle_login
      assigns(current_user).should == fake_result 
    end
  end
  describe 'logging in as a new user' do
    it 'should store the correct login flag in the sessions hash' do
    end
    it 'should redirect to the handle_auth method and receive the facebook hash' do
    end
    it 'should select the home page for rendering' do
    end
    it 'should make the error message available for display' do
    end
  end
  describe 'authentication fails' do
    it 'should store the correct login flag in the sessions hash' do
    end
    it 'should redirect to the handle_failure methods' do
    end
    it 'should select the home page for rendering' do
    end
    it 'should make the error message available for display' do
    end
  end
  
  describe 'signing out' do
    it 'should call the destroy method' do
    end
    it 'should remove the user id from the sessions hash' do
    end
    it 'should select the home page for rendering' do
    end
  end
end
    
