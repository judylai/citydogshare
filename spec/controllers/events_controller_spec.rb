require 'rails_helper'

describe EventsController, :type => :controller do
  include Capybara::DSL
  before(:each) do
    @user = FactoryGirl.create(:user)
    Dog.any_instance.stub(:geocode)
  end

  describe 'should render the events page' do
  before(:each) do
    session[:user_id] = "12345"
    Dog.any_instance.stub(:geocode)
    @dog = FactoryGirl.create(:dog)

  end
    it 'should render the form' do
      get :new
      expect(response).to render_template('new')
    end

    

