require 'rails_helper'

describe Dog do
  before(:each) do
      Time.stub(:now).and_return(Time.mktime(2014,1))
      s3_client = Aws::S3::Client.new(stub_responses: true)
      allow(Aws::S3::Client).to receive(:new).and_return(s3_client)
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

  it 'should parse simple youtube URL correctly' do
    @dog.video = "https://www.youtube.com/watch?v=to0JYZJxXOc"
    @dog.save
    expect(@dog.youtube_id).to eq("to0JYZJxXOc")
  end

  it 'should parse youtube URL with & correctly' do
    @dog.video = "https://www.youtube.com/watch?v=to0JYZJxXOc&something"
    @dog.save
    expect(@dog.youtube_id).to eq("to0JYZJxXOc")
  end
end
