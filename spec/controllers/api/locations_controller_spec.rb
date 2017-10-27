require 'rails_helper'

RSpec.describe Api::LocationsController, type: :controller do

  before do
    Rails.cache.write("user_ip_#{request.ip}_count", nil)
  end

  it "returns all locations when there are no current_user" do
    get :show, country_code: "LV"
    body = JSON.parse(response.body)
    
    # NOTE: I would like to create test data with FactoryGirl and test if returned data are correct.
    expect(body.count).to eq(5)
    expect(response.code).to eq("200")
  end
  
  it "returns error that country was not found" do
    get :show, country_code: "XX"
    body = JSON.parse(response.body)
    
    expect(response.code).to eq("404")
    expect(body["message"]).to eq("Country with country code XX not found")
  end
  
  context "Current User" do
    let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }
    
    before do
      TokenService.generate_token!(user.email)
      user.reload
      
      @request.headers['token'] = user.token
    end
    
    it "returns locations depending on users panel provider(user has no panels)" do
      get :show, country_code: "LV"
      body = JSON.parse(response.body)
      
      # NOTE: I would like to create test data with FactoryGirl and test if returned data are correct.
      expect(body.count).to eq(0)
      expect(response.code).to eq("200")
    end
    
    it "returns locations depending on users panel provider(user has panel)" do
      lv = Country.find_by(country_code: "LV")
      us = Country.find_by(country_code: "US")
      
      UserPanelProvider.create(active: true, user_id: user.id, panel_provider_id: lv.panel_provider.id)
      UserPanelProvider.create(active: true, user_id: user.id, panel_provider_id: us.panel_provider.id)
      
      get :show, country_code: lv.country_code
      body = JSON.parse(response.body)
      
      # NOTE: I would like to create test data with FactoryGirl and test if returned data are correct.
      expect(body.count).to eq(5)
      expect(response.code).to eq("200")
    end
  end

end
