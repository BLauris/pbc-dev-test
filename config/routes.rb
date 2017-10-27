Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do    
    # resources :tokens, except: [:index, :show, :create, :new, :edit, :update, :destroy] do
    #   collection do
    #     get :generate
    #   end
    # end
    
    get 'tokens', to: 'tokens#generate', as: :token_generate_path
    get 'locations/:country_code', to: 'locations#show', as: :location_path
    get 'target_groups/:country_code', to: 'target_groups#show', as: :target_group_path
    
    resources :evaluate_targets, only: [:create]
  end

end