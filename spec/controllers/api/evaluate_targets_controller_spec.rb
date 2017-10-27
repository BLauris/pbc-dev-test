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
    tg = TargetGroup.first
    locations = tg.countries.first.locations.map{ |c| {id: c.id, panel_size: rand(100...200)} }
    
    post :create, { evaluate_target: {
        country_code: tg.countries.first.country_code, 
        target_group_id: tg.id,
        locations: locations
      }
    }
    
    resp = JSON.parse(response.body)
    
    expect(response.code).to eq("200")
    expect(resp["message"]).to eq("Great Success")
  end

  it "returns errors when params not valid" do
    post :create, { evaluate_target: {
        country_code: "XX", 
        target_group_id: 9999,
        locations: [
          {id: 9999, panel_size: 150}, 
          {id: 1111, panel_size: 200}
        ]
      }
    }
    
    resp = JSON.parse(response.body)
    
    expect(response.code).to eq("406")
    expect(resp["errors"]["country_code"]).to eq("Country with code XX not found")
    expect(resp["errors"]["target_group_id"]).to eq("Target Group with id 9999 not found")
    expect(resp["errors"]["locations"]).to include("Location with 9999 not found", "Location with 1111 not found")
  end

end
