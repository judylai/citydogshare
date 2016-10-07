require 'rails_helper'

describe EventsController, :type => :controller do
  include Capybara::DSL
  before(:each) do
    session[:user_id] = "12345"
    s3_client = Aws::S3::Client.new(stub_responses: true)
    allow(Aws::S3::Client).to receive(:new).and_return(s3_client)
    @user = FactoryGirl.create(:user)
    Dog.any_instance.stub(:geocode)
    @dog = FactoryGirl.create(:dog)
    @form_filler = EventViewHelper.new(@user)
  end

  describe 'render the events page' do

    it 'should render the form' do
      get :new
      expect(response).to render_template('new')
    end

    it 'should redirect if no dogs' do
      @dog.delete
      get :new
      response.should redirect_to user_path(@user.id)
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


  end


  describe 'check other methods' do
    before (:each) do 
      @params = {"dogs"=>{"Spock"=>"1"}, "date_timepicker"=>{"start"=>"2015/04/17", "end"=>"2015/04/24"}, 
      "times"=>{"Morning"=>"1"}, "my_location"=>"My House", "description" => "", "update_dog_button"=>"Schedule", 
      "method"=>"post", "action"=>"create", "controller"=>"events"}
    end

    it 'should return the hash' do
      @form_filler.event_info(@params).should == {:start_date => DateTime.new(2015, 4, 17), :end_date => DateTime.new(2015, 4, 24),
        :time_of_day => ["Morning"], :my_location => "My House", :description => ""}
    end

    it 'should return stuff when empty' do
      @params = {"date_timepicker"=>{"start"=>"", "end"=>""}, "my_location"=>"My House", "description" => ""}
      @form_filler.event_info(@params).should == {:start_date => "", :end_date => "", :time_of_day => [], :my_location => "My House", :description=> ""}
    end


    it 'should set the flash if dogs is empty' do
      controller.instance_variable_set(:@dogs, [])
      controller.set_flash
      expect(flash[:notice]).to eq({:name => ["Please select a dog to share"]})
    end

    it 'should return false if event is invalid' do
      controller.instance_variable_set(:@dogs, [Dog.find_by_name("Spock")])
      controller.instance_variable_set(:@event_attr, {:start_date => "", :end_date => DateTime.new(2015, 4, 24),
        :time_of_day => ["Morning"], :my_location => "My House", :description => ""})
      controller.create_events.should == false
    end
  end

  describe 'show dog events' do
    before (:each) do
      @event1 = Event.new(:dog => Dog.find(1), :start_date => DateTime.new(2015, 4, 17), :end_date => DateTime.new(2015, 4, 24),
        :time_of_day => ["Morning"], :my_location => "true", :description => "")
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


  describe 'edit dog events' do
    before (:each) do
      @event1 = Event.new(:dog => Dog.find(1), :start_date => DateTime.new(2015, 4, 17), :end_date => DateTime.new(2015, 4, 24),
        :time_of_day => ["Morning"], :my_location => "true", :description => "")
      @event1.save
    end

    it 'should find the right event' do
      get :edit, {:id => 1}
      expect(controller.instance_variable_get(:@dog)).to eql(Dog.find(1))
      expect(controller.instance_variable_get(:@action)).to eql(:update)
      expect(controller.instance_variable_get(:@method)).to eql(:put)
    end

  end


  describe 'update event' do
    before (:each) do
      @event1 = Event.new(:dog => Dog.find(1), :start_date => DateTime.new(2015, 4, 17), :end_date => DateTime.new(2015, 4, 24),
        :time_of_day => ["Morning"], :my_location => "true", :description => "")
      @event1.save
      @params = {"method"=>"put", "date_timepicker"=>{"start"=>"2015/04/29", "end"=>"2015/04/29"}, 
      "times"=>{"Afternoon"=>"1"}, "my_location"=>"Your House", "description"=>"", 
      "update_dog_button"=>"Schedule", "action"=>"update", "controller"=>"events", "id"=>"1"}
    end

    it 'should redirect with good inputs' do
      get :update, @params
      expect(controller.instance_variable_get(:@event)).to eql(@event1)
      response.should redirect_to events_path
    end

    it 'should redirect back to edit if bad' do
      @params.delete("times")
      get :update, @params
      response.should redirect_to edit_event_path('1')
    end

    #it 'should change the event info' do


  end

  describe 'delete event' do
    before (:each) do
      @event1 = Event.new(:dog => Dog.find(1), :start_date => DateTime.new(2015, 4, 17), :end_date => DateTime.new(2015, 4, 24),
          :time_of_day => ["Morning"], :my_location => "true", :description => "")
      @event1.save
    end

    it 'should delete the event' do
      get :destroy, :id => "1"
      expect(controller.instance_variable_get(:@event)).to eql(@event1)
      assert_equal Event.all, []
    end




  end






end



