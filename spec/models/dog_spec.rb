require 'rails_helper'

describe Dog do
  before(:each) do
      Time.stub(:now).and_return(Time.mktime(2014,1))
      @user = User.create(:id => "1")
      @user.uid = "12345" 
      @user.first_name = "John"
      @user.last_name = "Smith"
      @user.save
  end

  it 'should calculate age correctly if under 1 year old' do
    @dog = Dog.create(:dob => DateTime.parse('3/2013'))
    @dog.save
    assert_equal @dog.age, 0
  end

  it 'should calculate age correctly if over 1 year old' do
    @dog = Dog.create(:dob => DateTime.parse('3/2011'))
    @dog.save
    assert_equal @dog.age, 2
  end

end