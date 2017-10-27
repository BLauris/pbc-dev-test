class ActivatePanelProviderService < Validators::ActivatePanel
  
  include Virtus.model(strict: true)
  attribute :user_id, Integer
  attribute :panel_provider_id, Integer
  attribute :errors, Array, default: :validate!
  
  def activate!
    if errors.blank?
      ActiveRecord::Base.transaction do
        upp = UserPanelProvider.find_or_create_by(
          panel_provider_id: panel_provider_id, 
          user_id: user_id
        )
        
        upp.active = true
        charge_user! if upp.save
      end
    end
  end
  
  private
  
    def charge_user!
      new_balance = (user.balance_in_cents - panel_provider.price_in_cents)
      user.update(balance_in_cents: new_balance)
    end
  
    def user
      @user ||= User.find(user_id)
    end
    
    def panel_provider
      @panel_provider ||= PanelProvider.find(panel_provider_id)
    end
    
    def validate!
      errors = []
      errors << has_enough_money?
      errors << already_active?
      errors.compact
    end
  
end