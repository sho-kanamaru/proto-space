Rails.application.routes.draw do
  root 'prototypes#index'

  resources :prototypes, only: [:index, :new, :show]
end
