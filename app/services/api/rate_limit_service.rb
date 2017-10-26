class Api::RateLimitService
  
  include Virtus.model
  attribute :ip, String
  attribute :count, Integer, default: :init_count
  
  def self.exceeded?(ip)
    rate_limit = self.new(ip: ip)
    rate_limit.check!
  end
  
  def check!
    if self.count < 5  
      self.count += 1
      write_cache
      
      return false
    else
      return set_expire_at_for_cache
    end
  end
  
  private
    
    def write_cache
      Rails.cache.write("user_ip_#{ip}_count", self.count)
    end
    
    def set_expire_at_for_cache
      Rails.cache.write("user_ip_#{ip}_count", self.count, expires_in: 1.minutes)
    end
    
    def init_count
      cache = Rails.cache.read("user_ip_#{ip}_count")
      cache.present? ? cache : 0 
    end
  
end