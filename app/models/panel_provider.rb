class PanelProvider < ActiveRecord::Base
  include Prices
  
  validates :code, :price_in_cents, presence: true
  
  has_many :countries
  has_many :location_groups
  
  has_many :user_panel_providers
  has_many :users, through: :user_panel_providers
  
end
