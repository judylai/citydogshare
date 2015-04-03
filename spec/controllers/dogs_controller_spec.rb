require 'rails_helper'

describe DogsController, :type => :controller do
  include Capybara::DSL

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
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy", :dob => DateTime.new(2014, 2))
      dogs = [dog2]
      params = {}
      params[:age] = {"0" => 1}
      get :index, params
      expect(assigns(:dogs)).to match_array(dogs)
    end

    it 'should filter by mix' do
      dog1 = FactoryGirl.create(:dog)
      dog2 = FactoryGirl.create(:dog, :name => "Fluffy")
      dog2.mixes << Mix.find_by_name("Labrador")
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
      dog2.personalities << Personality.find_by_name("friendly")
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
      dog2.likes << Like.find_by_thing("cats")
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
      params[:energy] = {"high" => 1}
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


end
