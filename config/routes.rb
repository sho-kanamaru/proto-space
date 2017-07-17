Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  namespace :prototypes do
    resources :newest, only: :index
  end

  resources :tags, only: [:index, :show]

  resources :prototypes, except: :index do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: :create
  end
  resources :users, only: [:show, :edit, :update]
end
