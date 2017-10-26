class PanelProvider < ActiveRecord::Base
  
  validates :code, :price_in_cents, presence: true
  
  has_many :countries
  has_many :location_groups
  
end
