class Base::CountryCodeQuery
  
  include Virtus.model
  attribute :user, User
  attribute :country_code, String
  
  private
  
    def user_panel_provider_ids
      @user_panel_provider_ids ||= 
        user.panel_providers
            .joins(:user_panel_providers)
            .where(user_panel_providers: { active: true })
            .pluck(:id)
    end
  
end