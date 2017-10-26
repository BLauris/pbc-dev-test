class ApiController < ApplicationController
  
  protect_from_forgery with: :null_session
  
  private
    
    def rate_limit_exceeded?
      unless TokenService.decode!(token)
        if RateLimitService.exceeded?(ip)
          render json: {message: "Rate limit exceeded!"}, status: 429 
        end
      end
    end
    
    def authenticate_user!
      unless TokenService.decode!(token)
        render json: {message: "You need to be authorized!"}, status: 401 
      end
    end
  
    def token
      request.headers["token"]
    end
  
end