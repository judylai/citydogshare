require 'spec_helper'

describe UsersController, :type => :controller do
  
  describe 'viewing a user profile' do
    it 'should find the user with the given id' do
      user1 = double('user1')
      User.should_receive(:find).with("1").and_return(user1)
      get(:show, {'id' => "1"}, nil)
    end
    it 'should make that user available to the view profile page' do
      user1 = double('user1')
      User.stub(:find).and_return(user1)
      assigns(:current_user).should == user1
      get(:show, {'id' => "1"}, nil)
    end
  end

end 
 
