class Location < ActiveRecord::Base
  
  validates :name, :country_id, presence: true

  belongs_to :country
  
  delegate :panel_provider_id, to: :country
  
end
