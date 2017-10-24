class PanelProvider < ActiveRecord::Base
  
  validates :code, presence: true
  
  has_many :countrues
  has_many :location_groups
  
end
