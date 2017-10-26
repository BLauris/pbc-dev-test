require 'rails_helper'

describe LocationService do
  
  let(:user) { User.first }
  let(:panel_provider) { PanelProvider.first }
  let(:country_code) { panel_provider.countries.pluck(:country_code).last }
  
  before do
    UserPanelProvider.create(
      user_id: user.id, 
      panel_provider_id: panel_provider.id,
      active: true
    )
  end
  
  it "returns location based on users panel_provider" do
    service = LocationService.new(current_user: user, country_code: country_code)
    expect(service.list.count).to eq(5)
  end
  
  it "returns all locations if no user provided" do
    
  end
  
end