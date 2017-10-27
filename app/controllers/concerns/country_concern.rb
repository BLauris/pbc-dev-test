module CountryConcern
  extend ActiveSupport::Concern
  
  def country_exists?
    Country.where(country_code: params[:country_code]).exists?
  end
  
end