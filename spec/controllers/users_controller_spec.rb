require 'rails_helper'

describe UsersController, :type => :controller do
  describe 'show user profile' do
    before(:each) do
      @user = User.create(:id => "1")
      @user.uid = "12345" 
      @user.save
    end
    it 'should get the current user from the params' do
      get(:show, :id => "1")
      assert_equal @user, assigns(:current_user)
    end
  end
end