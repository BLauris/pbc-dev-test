class LocationQuery

  include Virtus.model
  attribute :user, User
  attribute :country_code, String
  
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

    def user_panel_provider_ids
      @user_panel_provider_ids ||= 
        user.panel_providers
            .joins(:user_panel_providers)
            .where(user_panel_providers: { active: true })
            .pluck(:id)
    end
end