require 'rails_helper'

describe EventsController, :type => :controller do
  include Capybara::DSL
  before(:each) do
    session[:user_id] = "12345"
    @user = FactoryGirl.create(:user)
    Dog.any_instance.stub(:geocode)
    @dog = FactoryGirl.create(:dog)
  end

  describe 'render the events page' do

    it 'should render the form' do
      get :new
      expect(response).to render_template('new')
    end

    it 'should get all available times' do
      get :new
      assigns(:times).should == ["Morning", "Afternoon", "Evening", "Overnight"]
    end
  end

  describe 'create a new dog' do
    before (:each) do 
      @params = {"dogs"=>{"Spock"=>"1"}, "date_timepicker"=>{"start"=>"2015/04/17", "end"=>"2015/04/24"}, 
      "times"=>{"Morning"=>"1"}, "location"=>"true", "update_dog_button"=>"Schedule", 
      "method"=>"post", "action"=>"create", "controller"=>"events"}
    end

    it 'should call set_flash' do
      controller.should_receive(:set_flash)
      post :create, @params
    end

    it 'should redirect with correct info' do
      post :create, @params
      response.should redirect_to events_path
    end

    it 'should render new with incorrect params' do
      @params["dogs"] = {}
      post :create, @params
      response.should render_template 'new'
    end

    it 'should call set_vars_for_render' do
      @params["dogs"] = {}
      controller.should_receive(:set_vars_for_render)
      post :create, @params
    end


  end


end


