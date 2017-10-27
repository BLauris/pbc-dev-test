require 'rails_helper'

describe ActivatePanelProviderService do
  
  let(:panel_provider_one) { PanelProvider.last }
  let(:panel_provider_two) { PanelProvider.first }
  
  context "Happy Path" do
    let(:user) { User.first }
    
    before do
      UserPanelProvider.create(user_id: user.id, panel_provider_id: panel_provider_one.id)
    end
    
    it "activates existing panel for user" do
      activate_panel_service = ActivatePanelProviderService.new(user_id: user.id, panel_provider_id: panel_provider_one.id)
      inactive_upp = user.user_panel_providers.where(active: false)
      upp = user.user_panel_providers.where(active: true)
      user_old_balance = user.balance_in_cents
      
      expect(inactive_upp.count).to eq(1)
      expect(upp.count).to eq(0)
      
      activate_panel_service.activate!
      user.reload
      
      expect(user.balance_in_cents).to eq(user_old_balance - panel_provider_one.price_in_cents)
      expect(inactive_upp.count).to eq(0)
      expect(upp.count).to eq(1)    
    end
    
    it "creates and activates new user panel provider" do
      activate_panel_service = ActivatePanelProviderService.new(user_id: user.id, panel_provider_id: panel_provider_two.id)
      inactive_upp = user.user_panel_providers.where(active: false)
      upp = user.user_panel_providers.where(active: true)
      user_old_balance = user.balance_in_cents
      
      expect(inactive_upp.count).to eq(1)
      expect(upp.count).to eq(0)
      
      activate_panel_service.activate!
      user.reload
      
      expect(user.balance_in_cents).to eq(user_old_balance - panel_provider_two.price_in_cents)
      expect(inactive_upp.count).to eq(1)
      expect(upp.count).to eq(1)
    end
  end
  
  context "Sad Path" do
    let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }
    
    before do
      UserPanelProvider.create(user_id: user.id, panel_provider_id: panel_provider_one.id, active: true)
    end
    
    it "returns errors" do
      activate_panel_service = ActivatePanelProviderService.new(user_id: user.id, panel_provider_id: panel_provider_one.id)
      upp = user.user_panel_providers.where(active: true)
      user_old_balance = user.balance_in_cents
      
      activate_panel_service.activate!
      
      expect(user.balance_in_cents).to eq(user_old_balance)
      expect(activate_panel_service.errors).to include("User with id #{user.id} doens't have enough money")
      expect(activate_panel_service.errors).to include("User with id #{user.id} already owns panel provider with id #{panel_provider_one.id}")
    end
  end
end