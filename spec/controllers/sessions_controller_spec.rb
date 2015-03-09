require 'spec_helper'

describe SessionsController, :type => :controller do

  describe 'logging in as an existing user' do
    before (:each) do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
    end 

    it 'should find the user' do
      User.should_receive(:find_by_uid).with(request.env["omniauth.auth"][:uid])
      visit "/auth/facebook?type=login"
    end 

    it 'should update their credentials' do
      user1 = User.create(:uid => "12345", :name => "Batman")
      User.should_receive(:find_by_uid).with(request.env["omniauth.auth"][:uid]).and_return(user1)
      visit "/auth/facebook?type=login"
      user1.oauth_token.should == request.env["omniauth.auth"][:credentials][:token]
      user1.oauth_expires_at.should == request.env["omniauth.auth"][:credentials][:expires_at]
    end 

    it 'should redirect to the user profile page' do 
      user1 = User.create(:uid => "12345")
      User.should_receive(:find_by_uid).with(request.env["omniauth.auth"][:uid]).and_return(user1)
      visit "/auth/facebook?type=login"
      response.should render_template("users/show")
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
    
