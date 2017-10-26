require 'rails_helper'

RSpec.describe Api::EvaluateTargetsController, type: :controller do

  let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }

  before do
    TokenService.generate_token!(user.email)
    user.reload
  end

  it "returns success status" do
    @request.headers['token'] = user.token
    
    post :create, {}
    resp = JSON.parse(response.body)
    
    expect(response.code).to eq("200")
    expect(resp["message"]).to eq("Created")
  end

  it "returns unauthorized" do
    @request.headers['token'] = "invalid_token"
    
    post :create, {}
    resp = JSON.parse(response.body)
    
    expect(response.code).to eq("401")
    expect(resp["message"]).to eq("You need to be authorized!")
  end

end
