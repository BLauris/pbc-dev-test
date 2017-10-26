require 'rails_helper'

describe Api::TokenService do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:non_existing_email) { FactoryGirl.create(:user) }
  
  
  it "should generate and save token to user" do
    Timecop.freeze(DateTime.current.in_time_zone)
    
    expect(user.token.present?).to eq(false) 
    expect(user.token_expires_at.present?).to eq(false) 
    
    Api::TokenService.generate_token!(user.email)
    user.reload
    
    expect(user.token.present?).to eq(true) 
    # expect(user.token_expires_at).to eq(DateTime.current.in_time_zone + 1.day)
  end
  
  it "returns nil for email that doesn't exist" do
    expect(Api::TokenService.generate_token!("non_existing@example.com")).to eq(nil)
  end
  
  it "successfully decodes token" do
    token = Api::TokenService.generate_token!(user.email)
    
    expect(Api::TokenService.decode!(token)).to eq(true)
  end
  
  it "returns error when trying to decode random string" do
    decode = Api::TokenService.decode!("some_random_token")
    expect(decode).to eq("Invalid token")
  end 
  
  it "returns error if token expired" do
    # Api::TokenService.generate_token!(user.email)
    # 
    # Timecop.travel(Time.now + 2.days) do
    #   user.reload
    #   
    #   decode = Api::TokenService.decode!(user.token)
    #   expect(decode[:message]).to eq("Token expired")
    # end
  end
  
end