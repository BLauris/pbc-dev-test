class Country < ActiveRecord::Base
  
  validate :country_code, :panel_provider_id, presence: true
  
end
