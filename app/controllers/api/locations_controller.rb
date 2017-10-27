class Api::LocationsController < ApiController
  
  before_action :rate_limit_exceeded?
  
  def show
    if country_exists?
      query = LocationQuery.new(user: current_user, country_code: params[:country_code])
      render json: query.list, each_serializer: LocationSerializer, status: 200
    else
      render json: { message: "Country with country code #{params[:country_code]} not found" }, status: 404
    end    
  end
  
end
