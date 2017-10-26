class Api::LocationsController < ApiController
  
  before_action :rate_limit_exceeded?
  
  def show
    service = LocationService.new(current_user: current_user, country_code: params[:country_code])
    
    if service.location.present?
      
    else
      render json: { message: "Location with #{params[:country_code]} not found" }
    end
  end
  
end
