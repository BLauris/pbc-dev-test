Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do    
    resources :tokens, except: [:index, :show, :create, :new, :edit, :update, :destroy] do
      collection do
        get :generate
      end
    end
    
    resources :locations, only: [:show]
    resources :evaluate_targets, only: [:create]
  end

end