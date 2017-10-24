class LocationGroup < ActiveRecord::Base
  
  validates :name, :country_id, :panel_provider_id, presence: true
  
  belongs_to :country
  belongs_to :panel_provider
  
end
