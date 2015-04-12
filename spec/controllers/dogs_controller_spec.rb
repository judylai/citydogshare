require 'rails_helper'

describe DogsController, :type => :controller do
  include Capybara::DSL
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe 'searching/viewing dogs' do
    it 'should display all dogs initially' do
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy")
      dogs = [dog1, dog2]
      get :index
      expect(assigns(:dogs)).to match_array(dogs)
    end
    it 'should filter by gender' do
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy", :gender => "Female")
      dogs = [dog2]
      params = {}
      params[:gender] = {"Female" => 1}
      get :index, params
      expect(assigns(:dogs)).to match_array(dogs)
    end
    it 'should filter by age' do
      Time.stub(:now).and_return(Time.mktime(2014,1))
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy", :dob => Time.new(2013, 2))
      dogs = [dog2]
      params = {}
      params[:age] = {"0" => 1}
      get :index, params
      expect(assigns(:dogs)).to match_array(dogs)
    end

    it 'should filter by mix' do
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy")
      dog2.mixes << Mix.find_by_value("Labrador")
      dog2.save!
      dogs = [dog2]
      params = {}
      params[:mix] = "Labrador"
      get :index, params
      expect(assigns(:dogs)).to match_array(dogs)
    end
    
    it 'should filter by personality' do
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy")
      dog2.personalities << Personality.find_by_value("friendly")
      dog2.save
      dogs = [dog2]
      params = {}
      params[:personality] = {"friendly" => 1}
      get :index, params
      expect(assigns(:dogs)).to match_array(dogs)
    end

    it 'should filter by likes' do
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy")
      dog2.likes << Like.find_by_value("cats")
      dog2.save
      dogs = [dog2]
      params = {}
      params[:like] = {"cats" => 1}
      get :index, params
      expect(assigns(:dogs)).to match_array(dogs)
    end
   
    it 'should filter by energy level' do
      dog1 = FactoryGirl.create(:dog, :energy_level_id => 2)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy")
      dogs = [dog2]
      params = {}
      params[:energy_level] = {"high" => 1}
      get :index, params
      expect(assigns(:dogs)).to match_array(dogs)
    end

    it 'should filter by size' do
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy", :size_id => 2)
      dogs = [dog1]
      params = {}
      params[:size] = {"small (0-15)" => 1}
      get :index, params
      expect(assigns(:dogs)).to match_array(dogs)
    end

    it 'should handle multiple criteria' do
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy", :size_id => 2)
      dogs = [dog1]
      params = {}
      params[:gender] = {"Male" => 1}
      params[:size] = {"small (0-15)" => 1}
      get :index, params
      expect(assigns(:dogs)).to match_array(dogs)
    end
    
    it 'should report when no results match criteria' do
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy", :size_id => 2)
      params = {}
      params[:size] = {"xl(101+)" => 1}
      get :index, params
      expect(assigns(:no_dogs)).to eq(true)
    end
  end


  describe 'render new dog page' do
  before(:each) do
    @dog = FactoryGirl.create(:dog)
    @current_user = User.create(:id => 1)
  end
    it "should render the form" do
      get :new
      expect(response).to render_template('new')
    end

    it 'should create an array of likes' do
      get :new
      assigns(:likes).should == ["dogs (all)", "dogs (some or most)", "cats", "men", "women", "children"]
    end
  end

  describe 'create a new dog' do 
  before(:each) do
    @dog = FactoryGirl.create(:dog)
    @current_user = User.create(:id => 1)
      @params = {  "dog"=>{"name"=>"Lab", "dob(1i)"=>"2010", "dob(2i)"=>"4", "dob(3i)"=>"4", "gender"=>"Male",
                  "size"=>"1", "motto"=>"Hi", "description"=>"", "energy_level"=>"1", "health"=>"", "fixed"=>"true",
                  "availability"=>""}, "item"=>{"tags"=>["Australian Shepherd"]}, "personality"=>{"curious"=>"1"},
                  "likes"=>{"dogs (some or most)"=>"1", "men"=>"1"}, "update_dog_button"=>"Save Changes"}
    end

    it 'should create an array of personalities' do
      get :new
      assigns(:personalities).should == ["anxious", "curious", "timid", "whatever", "friendly", "fetcher", "lover", "still a puppy"]
    end

    it "create should call attributes_list" do
      new_hash = controller.attributes_list(@params)
      new_hash.should include('fixed')
      new_hash.should include(:energy_level)
    end

    it 'should call attributes_list' do
      controller.stub(:current_user).and_return(@current_user)
      post :create, @params
      response.should redirect_to user_path(@current_user)
    end

    it 'should redirect with bad params' do
      @params['dog']['name'] = ""
      controller.stub(:current_user).and_return(@current_user)
      post :create, @params
      response.should redirect_to new_dog_path
    end


  end

  describe 'should show the correct dog profile' do
  before(:each) do
    @dog = FactoryGirl.create(:dog)
    @current_user = User.create(:id => 1)
  end
    it 'render the html' do
      get :show, {:id => '1'}
      expect(response).to render_template('show')
    end
  end

  describe 'test get_mix_array' do
  before(:each) do
    @dog = FactoryGirl.create(:dog)
    @current_user = User.create(:id => 1)
  end
    it 'should return an array of mix objects' do
      controller.get_mix_array({"item"=>{"tags"=>["Czechoslovak Wolfdog"]}}).should == [Mix.find_by_value("Czechoslovak Wolfdog")]
    end

    it 'should return an empty array if no params' do
      controller.get_mix_array({}).should == []
    end
  end

  describe 'test other methods' do
  before(:each) do
    @dog = FactoryGirl.create(:dog)
    @current_user = User.create(:id => 1)
  end
    it 'get_size_object should return a size object' do
      controller.get_size_object({'size' => '1'}).should be_kind_of(Size)
    end

    it 'get_energy_object should return energy object' do
      controller.get_energy_object({'energy_level' => '1'}).should be_kind_of(EnergyLevel)
    end

    it 'get_attributes_array should return an array' do
      controller.get_attribute_array({'likes' => {'cats' => '1'}}, 'likes').should == [Like.find_by_value('cats')]
    end

    it 'should return empty array if blank' do
      controller.get_attribute_array({}, 'likes').should == []
    end


    it 'should get a dog birthday' do
      controller.get_birthday({ "dob(1i)"=>"2010", "dob(2i)"=>"4", "dob(3i)"=>"4",}).should == DateTime.new(2010, 4, 4)
    end
  end

end
