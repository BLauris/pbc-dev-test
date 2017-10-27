class LocationQuery < Base::CountryCodeQuery
  
  def list
    user.present? ? user_locations : all_locations
  end
  
  private
  
    def user_locations
      all_locations.select{ |location| user_panel_provider_ids.include?(location.panel_provider_id) }
    end
    
    def all_locations
      @all_locations ||= Location.includes(:country).where(countries: { country_code: country_code })
    end
    
end