class UserPanelProvider < ActiveRecord::Base
  
  validates :user_id, :panel_provider_id, presence: true
  
  belongs_to :user
  belongs_to :panel_provider
    
end
