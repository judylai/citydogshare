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

  describe 'create a new dog event' do
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

  describe 'check other methods' do
    before (:each) do 
      @params = {"dogs"=>{"Spock"=>"1"}, "date_timepicker"=>{"start"=>"2015/04/17", "end"=>"2015/04/24"}, 
      "times"=>{"Morning"=>"1"}, "location"=>"true", "update_dog_button"=>"Schedule", 
      "method"=>"post", "action"=>"create", "controller"=>"events"}
    end

    it 'should return an array of dogs names' do
      controller.get_dogs(@params).should == [Dog.find_by_name("Spock")]
    end

    it 'should return an empty array if no dogs' do
      @params.delete('dogs')
      controller.get_dogs(@params).should == []
    end

    it 'should return an new hash for the dog' do
      controller.attributes_list(@params).should == {:start_date => DateTime.new(2015, 4, 17), :end_date => DateTime.new(2015, 4, 24),
        :time_of_day => ["Morning"], :my_location => "true"}
    end

    it 'should return stuff when empty' do
      @params = {"date_timepicker"=>{"start"=>"", "end"=>""}, "location"=>"true"}
      controller.attributes_list(@params).should == {:start_date => "", :end_date => "", :time_of_day => [], :my_location => "true"}
    end

    it 'should set the flash if dogs is empty' do
      controller.stub(:create_events).and_return(true)
      controller.instance_variable_set(:@dogs, [])
      controller.set_flash
      expect(flash[:notice]).to eq({:name => ["Please select a dog to share"]})
    end

    it 'should return false if event is invalid' do
      controller.instance_variable_set(:@dogs, [Dog.find_by_name("Spock")])
      controller.stub(:attributes_list).and_return({:start_date => "", :end_date => DateTime.new(2015, 4, 24),
        :time_of_day => ["Morning"], :my_location => "true"})
      controller.create_events.should == false
    end
  end

  describe 'show dog events' do
    before (:each) do
      @event1 = Event.new(:dog => Dog.find(1), :start_date => DateTime.new(2015, 4, 17), :end_date => DateTime.new(2015, 4, 24),
        :time_of_day => "---\n- Morning\n", :my_location => "true")
      @event1.save
    end

    it 'should get the correct dog' do
      get :index
      assigns(:dog) == Dog.find(1)
    end

    it 'should get all dog events' do
      get :index
      assigns(:events).should == [@event1]
    end

    it 'should get the right event on show' do
      get :show, {:id => 1}
      assigns(:event).should == @event1
    end
  end


end


