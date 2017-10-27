class Validators::TargetEvaluation
  
  def validate_country
    unless Country.where(country_code: country_code).exists?
      "Country with code #{country_code} not found"
    end
  end
  
  def validate_target_group
    unless TargetGroup.where(id: target_group_id).exists?
      "Target Group with id #{target_group_id} not found"
    end
  end
  
  def validate_locations
    errors = locations.each_with_object([]) do |location, messages| 
      unless Location.where(id: location[:id]).exists?
        messages << "Location with #{location[:id]} not found"
      end
    end
    
    errors if errors.present?
  end
  
end