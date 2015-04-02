require 'rails_helper'

describe DogsController, :type => :controller do
  include Capybara::DSL

  describe 'view all dogs' do
    it 'should display all dogs in the database' do
      dog1 = Dog.create(:name => "Alex", :gender => "Female", :size_id => 1)
      dog2 = Dog.create(:name => "bandit", :gender => "Male", :size_id => 4)
      dogs = [dog1, dog2]
      params[:gender] = ['Male', 'Female']
      params[:mix] = 'All Mixes'
      params[:personalities] = ['anxious', 'curious', 'timid', 'whatever', 'friendly', 'fetcher', 'lover', 'still a puppy']
      params[:likes] = ['dogs (all)', 'dogs (some or most)', 'cats', 'men', 'women', 'children']
      params[:sizes] = ['small (0-15)', 'medium (16-40)', 'large (41-100)', 'xl (101+)']
      params[:energy] = ['high', 'active', 'good', 'some', 'low', 'zzzzz']
      get(:dogs, params)
      expect(assigns(:dogs)).to == dogs
    end
  end

  describe 'search for existing dog' do
    it 'should select the right subset of dogs' do
      dog1 = Dog.create(:name => "Alex", :gender => "Female", :size_id => 1)
      dog2 = Dog.create(:name => "bandit", :gender => "Male", :size_id => 4)
      dogs = [dog2]
      params[:gender] = ['Male']
      get(:dogs, params)
      expect(assigns(:dogs)).to == dogs
    end 
  end

  describe 'no dogs match search criteria' do
    it 'should say no dogs were found' do
      dog1 = Dog.create(:name => "Alex", :gender => "Female", :size_id => 1)
      dog2 = Dog.create(:name => "bandit", :gender => "Male", :size_id => 4)
      params[:sizes] = ['medium (16-40)']
      get(:dogs, params)
      expect(flash[:notice]).to == "No Dogs Found"
    end
  end

end
