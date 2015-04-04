require 'rails_helper'

describe Dog do
  before(:each) do
      Time.stub(:now).and_return(Time.mktime(2014,1))
      @dog = FactoryGirl.create(:dog)
  end


  it 'should correctly show name' do
    assert_equal @dog.name, "Spock"
  end

  it 'should not save an invalid date of birth' do
    @dog.dob = DateTime.parse("3/2017")
    @dog.valid?
    @dog.errors.should have_key(:dob)
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

  it 'should not save profile with unfilled name' do
    @dog.name = nil
    @dog.save
    @dog.errors.should have_key(:name)
  end
end
