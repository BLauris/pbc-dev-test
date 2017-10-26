require 'rails_helper'

RSpec.describe PanelProvider, type: :model do
  
  let(:panel_provider) { PanelProvider.new }
  
  it "successfully add's 'country'" do
    panel_provider.code = "XXXXX"
    panel_provider.price_in_cents = 2000
    
    expect{
      panel_provider.save 
    }.to change{PanelProvider.count}.by(1)
  end
  
  it "doesn't save 'country' with missing details" do
    expect(panel_provider.save).to eq(false)
    expect(panel_provider.errors.messages[:code]).to include("can't be blank")
    expect(panel_provider.errors.messages[:price_in_cents]).to include("can't be blank")
  end
  
end
