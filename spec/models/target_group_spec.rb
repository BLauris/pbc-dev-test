require 'rails_helper'

RSpec.describe TargetGroup, type: :model do
  
  let(:panel_provider) { FactoryGirl.create(:panel_provider) }
  let(:target_group_1) { TargetGroup.create(name: "TG1", panel_provider_id: panel_provider.id) }
  let(:target_group_2) { TargetGroup.create(panel_provider_id: panel_provider.id, parent_id: target_group_1.id) }
  
  it "successfully add's 'country'" do
    target_group_2.name = "TG2"
    
    expect{ target_group_2.save }.to change{TargetGroup.count}.by(1)
    expect(target_group_2.parent).to eq(target_group_1)
  end
  
  it "doesn't save 'country' with missing details" do
    expect(target_group_2.save).to eq(false)
    expect(target_group_2.errors.messages[:name]).to include("can't be blank")
  end
  
end
