require 'spec_helper'

describe SessionsController, :type => :controller do

  describe 'logging in as an existing user' do


    it 'should find the user' do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
      User.should_receive(:find_by_uid).with(request.env["omniauth.auth"][:uid])
      visit "/auth/facebook?type=login"
    end 

    it 'should update their credentials' do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
      user1 = User.create(:uid => "12345")
      User.should_receive(:find_by_uid).with(request.env["omniauth.auth"][:uid]).and_return(user1)
      visit "/auth/facebook?type=login"
      user1.oauth_token.should == request.env["omniauth.auth"][:credentials][:token]
      user1.oauth_expires_at.should == request.env["omniauth.auth"][:credentials][:expires_at]
    end 

    it 'should redirect to the user profile page' do 
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
      user1 = User.create(:uid => "12345")
      User.should_receive(:find_by_uid).with(request.env["omniauth.auth"][:uid]).and_return(user1)
      visit "/auth/facebook?type=login"
      response.should redirect_to user_path(user1.id)
    end


    it 'should make the user name available for display' do
      #request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
      #fake_result = double('user1')
      #User.should_receive(:find_by_uid).with(request.env["omniauth.auth"]["uid"]).and_return(fake_result)
      #get :login
      #assigns(current_user).should == fake_result 
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
    
