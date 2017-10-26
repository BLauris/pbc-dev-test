require 'rails_helper'

describe Api::TokenService do
  
  let(:ip) { "192.168.1.100" }
  
  before do
    Rails.cache.write("user_ip_#{ip}_count", nil)
  end
  
  it "retuns message that rate limit is exceeded" do
    exceeded = false
    
    until exceeded
      exceeded = Api::RateLimitService.exceeded?(ip)
      puts exceeded
    end
    
    expect(Rails.cache.read("user_ip_#{ip}_count")).to eq(5)
  end
  
end