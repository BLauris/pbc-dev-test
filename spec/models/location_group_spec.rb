require 'rails_helper'

RSpec.describe LocationGroup, type: :model do
  
  let(:panel_provider) { FactoryGirl.create(:panel_provider) }
  let(:country) { FactoryGirl.create(:country, panel_provider_id: panel_provider.id, country_code: "RU") }
  let(:location_group) { LocationGroup.new }
  
  it "successfully add's 'country'" do
    location_group.name = "Location Group 1"
    location_group.panel_provider_id = panel_provider.id
    location_group.country_id = country.id
    
    expect{
      location_group.save 
    }.to change{LocationGroup.count}.by(1)
  end
  
  it "doesn't save 'country' with missing details" do
    expect(location_group.save).to eq(false)
    expect(location_group.errors.messages[:name]).to include("can't be blank")
  end
  
end