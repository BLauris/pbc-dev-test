class PanelProvider < ActiveRecord::Base
  
  validates :code, presence: true
  
  has_many :countries
  has_many :location_groups
  
end
