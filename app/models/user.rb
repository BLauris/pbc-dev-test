class User < ActiveRecord::Base
  
  validates :email, presence: true
  validates_uniqueness_of :email
  
  has_many :user_panel_providers
  has_many :panel_providers, through: :user_panel_providers

  scope :active_panel, -> { joins(:panel_providers).where(panel_providers: {active: true}) }
  
end
