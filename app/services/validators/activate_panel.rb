class Validators::ActivatePanel
  
  def has_enough_money?
    if user.balance_in_cents < panel_provider.price_in_cents
      "User with id #{user_id} doens't have enough money"
    end
  end
  
  def already_active?
    if UserPanelProvider.where(user_id: user_id, panel_provider_id: panel_provider_id, active: true).exists?
      "User with id #{user_id} already owns panel provider with id #{panel_provider_id}"
    end    
  end
end