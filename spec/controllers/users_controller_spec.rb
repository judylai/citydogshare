require 'rails_helper'

describe UsersController, :type => :controller do

  describe 'edit user profile' do
    before(:each) do
      @user = User.create(:id => "1")
      @user.uid = "12345" 
      session[:user_id] = "12345"
    end
    it 'should render edit if no user params' do
      get(:edit, {:id => "1"}, {:user_id => "12345"})
      expect(response).to render_template("edit")
    end 
    it 'should redirect to edit if phone format incorrect' do
      controller.instance_variable_set(:@current_user, @user)
      get(:edit, {:id => "1", :user => {:phone_number => "abc"}}, {:user_id => "12345"})
      expect(response).to render_template("edit")
    end 
    it 'should redirect to user page if given correct params' do
      controller.instance_variable_set(:@current_user, @user)
      get(:edit, {:id => "1", :user => {:phone_number => "(510)123-1234"}, :status => "Looking", :availability => "All the time"}, {:user_id => "12345"})
      expect(response).to redirect_to user_path(:id => "1")
    end 
    it 'should update user info if given all params' do
      controller.instance_variable_set(:@current_user, @user)
      get(:edit, {:id => "1", :user => {:location => "Berkeley, CA", :description => "Hello!", :phone_number => "(510)123-1234", :status => "Looking", :availability => "All the time"}}, {:user_id => "12345"})
      @user = User.find_by_id("1")
      assert_equal @user.location, "Berkeley, CA"
      assert_equal @user.description, "Hello!"
      assert_equal @user.phone_number, "(510)123-1234"
      assert_equal @user.status, "Looking"
      assert_equal @user.availability, "All the time"
    end 
    it 'should update user info if given some params' do
      controller.instance_variable_set(:@current_user, @user)
      get(:edit, {:id => "1", :user => {:description => "Hello!", :phone_number => "(510)123-1234"}}, {:user_id => "12345"})
      @user = User.find_by_id("1")
      assert_equal @user.location, nil
      assert_equal @user.description, "Hello!"
      assert_equal @user.phone_number, "(510)123-1234"
      assert_equal @user.availability, nil
    end 
  end

  describe 'delete user profile' do
    before(:each) do
      @user = User.create(:id => "1")
      @user.uid = "12345" 
      session[:user_id] = "12345"
    end
    it 'should remove user from database' do
      controller.instance_variable_set(:@current_user, @user)
      get(:destroy, :id => "1")
      assert_equal User.all, []
    end
    it 'should nullify the user id in the session hash' do
      controller.instance_variable_set(:@current_user, @user)
      get(:destroy, :id => "1")
      assert_equal session[:user_id], nil
    end
  end

end