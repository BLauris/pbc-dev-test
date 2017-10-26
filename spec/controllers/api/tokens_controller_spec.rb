require 'rails_helper'

RSpec.describe Api::TokensController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  
  it "returns valid token" do
    get :generate, user: { email: user.email } 
    
    user.reload
    
    resp = JSON.parse(response.body)
    expect(resp["token"]).to eq(user.token)
  end

end
