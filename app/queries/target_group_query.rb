class TargetGroupQuery < Base::CountryCodeQuery
  
  def list
    user.present? ? user_target_groups : all_target_groups
  end
  
  private
  
    def user_target_groups
      tgs = TargetGroup.includes(:panel_provider)
                       .where(panel_providers: { id: user_panel_provider_ids })
                       .select{ |tg| tg.panel_provider.countries.pluck(:country_code).include?(country_code) }
                      
      tgs.present? ? tgs.first.self_and_descendants : tgs
    end
    
    def all_target_groups
      tgs = TargetGroup.joins(:countries)
                       .where(countries: { country_code: country_code })
                       
      tgs.present? ? tgs.first.self_and_descendants : tgs
    end 
  
end