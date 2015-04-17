require 'rails_helper'

describe Dog do
  before(:each) do
      Time.stub(:now).and_return(Time.mktime(2014,1))
      AWS::S3::S3Object.stub(method).and_return(double('response', :success? => success))
      allow_any_instance_of(Paperclip::Attachment).to receive(:save).and_return(true)
      @user = FactoryGirl.create(:user)
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
    @dog.dob = DateTime.parse('3/2013')
    @dog.save
    assert_equal @dog.age, 0
  end

  it 'should calculate age correctly if over 1 year old' do
    @dog.dob = DateTime.parse('3/2011')
    @dog.save
    assert_equal @dog.age, 2
  end

  it 'should not save profile with unfilled name' do
    @dog.name = nil
    @dog.save
    @dog.errors.should have_key(:name)
  end

  it 'should not save profile with empty mix' do
    @dog.mixes = []
    @dog.save
    @dog.errors.should have_key(:mixes)
  end
end
