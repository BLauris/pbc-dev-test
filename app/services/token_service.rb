class TokenService
  
  include Virtus.model(strict: true)
  attribute :email, String
  
  def self.generate_token!(email)
    token = self.new(email: email)
    token.generate!
  end
  
  def self.decode!(token)
    decoded = JWT.decode(token, nil, false)
    User.find_by(email: decoded.first["email"])
  rescue
    nil
  end
  
  def generate!
    if user.present?
      user.update(token: token, token_expires_at: token_expires_at)
      user.token
    end
  end
  
  private
  
    def user
      @user ||= User.find_by(email: email)
    end
    
    def token
      @token ||= token = JWT.encode(payload, nil, 'none')
    end
    
    def payload
      { email: user.email, exp: token_expires_at }
    end
    
    def token_expires_at
      @token_expires_at ||= DateTime.current.in_time_zone + 1.day
    end
    
end