Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes, except: :index
  resources :users, only: [:show, :edit, :update]
end
