class ApiController < ApplicationController
  
  protect_from_forgery with: :null_session
    
  helper_method :current_user, :country_exists?
  
  private
    
    def rate_limit_exceeded?
      unless current_user.present?
        if RateLimitService.exceeded?(request.ip)
          render json: {message: "Rate limit exceeded!"}, status: 429 
        end
      end
    end
    
    def authenticate_user!
      unless current_user.present?
        render json: {message: "You need to be authorized!"}, status: 401 
      end
    end
    
    def current_user
      TokenService.decode!(request.headers["token"])
    end
  
end