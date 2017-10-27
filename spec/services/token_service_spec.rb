require 'rails_helper'

describe TokenService do
  
  let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email) }
  
  it "should generate and save token to user" do
    Timecop.freeze(DateTime.current.in_time_zone)
    
    expect(user.token.present?).to eq(false) 
    expect(user.token_expires_at.present?).to eq(false) 
    
    TokenService.generate_token!(user.email)
    user.reload
    
    expect(user.token.present?).to eq(true) 
    # expect(user.token_expires_at).to eq(DateTime.current.in_time_zone + 1.day)
  end
  
  it "returns nil for email that doesn't exist" do
    expect(TokenService.generate_token!("non_existing@example.com")).to eq(nil)
  end
  
  it "successfully decodes token" do
    token = TokenService.generate_token!(user.email)
    
    expect(TokenService.decode!(token)).to eq(user)
  end
  
  it "returns false when trying to decode random string" do
    expect(TokenService.decode!("some_random_token")).to eq(nil)
  end 
  
  it "returns error if token expired" do
    # TokenService.generate_token!(user.email)
    # 
    # Timecop.travel(Time.now + 2.days) do
    #   user.reload
    #   
    #   decode = TokenService.decode!(user.token)
    #   expect(decode[:message]).to eq("Token expired")
    # end
  end
  
end