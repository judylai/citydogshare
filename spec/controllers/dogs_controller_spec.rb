require 'rails_helper'

describe DogsController, :type => :controller do
  include Capybara::DSL

  describe 'searching/viewing dogs' do
    it 'should display all dogs initially' do
      dogs = Dog.all
      get :index
      expect(assigns(:dogs)).to match_array(dogs)
    end
    it 'should filter by gender' do
      dogs = Dog.find_by_gender("Female")
      params = {} 
      params[:gender] = {"Female" => 1}
      get :index, params
      expect(assigns(:dogs)).to match_array(dogs)
    end
  end


end
