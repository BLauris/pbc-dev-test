require 'rails_helper'

RSpec.describe Location, type: :model do
  
  let(:location) { Location.new }
  let(:country) { Country.last }
  
  it "successfully add's 'country'" do
    location.name = "Some random string"
    location.country_id = country.id
    
    expect{
      location.save 
    }.to change{Location.count}.by(1)
  end
  
  it "doesn't save 'country' with missing details" do
    expect(location.save).to eq(false)
    expect(location.errors.messages[:name]).to include("can't be blank")
  end
  
end
