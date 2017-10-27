require 'rails_helper'

RSpec.describe Api::EvaluateTargetsController, type: :controller do

  let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }

  before do
    TokenService.generate_token!(user.email)
    user.reload
    
    @request.headers['token'] = user.token
  end

  it "returns unauthorized" do
    @request.headers['token'] = "invalid_token"
    
    post :create, {}
    resp = JSON.parse(response.body)
    
    expect(response.code).to eq("401")
    expect(resp["message"]).to eq("You need to be authorized!")
  end

  it "returns successfull evaluation" do
    tg = TargetGroup.where(panel_provider_id: nil).last
    locations = Location.where(country_id: nil).each_with_object([]){|l, o| o << {id: l.id, panel_size: 100}}
    
    VCR.use_cassette("returns_successfull_evaluation") do
      panel_provider_count = PanelProvider.count
      country_count = Country.count
      target_group_count = TargetGroup.count
      location_count = Location.count
      
      post :create, { evaluate_target: {
          country_code: "LV", 
          target_group_id: tg.id,
          locations: locations
        }
      }
      
      resp = JSON.parse(response.body)
      
      expect(response.code).to eq("200")
      expect(resp.count).to eq(3)
      expect(PanelProvider.count).to eq(panel_provider_count + 3)
      expect(Country.count).to eq(country_count + 3)
      expect(TargetGroup.count).to eq(target_group_count + 3)
      expect(Location.count).to eq(location_count)
    end
  end

  it "returns errors when params not valid" do
    location = Country.find_by(country_code: "LV").locations.first
    
    post :create, { evaluate_target: {
        country_code: "XX", 
        target_group_id: 9999,
        locations: [
          {id: 9999, panel_size: 150}, 
          {id: 1111, panel_size: 200},
          {id: location.id, panel_size: 300}
        ]
      }
    }
    
    resp = JSON.parse(response.body)
    
    expect(response.code).to eq("406")
    expect(resp["errors"]).to include("Country with code XX not found")
    expect(resp["errors"]).to include("Target Group with id 9999 not found")
    expect(resp["errors"]).to include("Location with 9999 not found")
    expect(resp["errors"]).to include("Location with 1111 not found")
    expect(resp["errors"]).to include("Location with #{location.id} already belongs to country with code #{location.country.country_code}")
  end

end
