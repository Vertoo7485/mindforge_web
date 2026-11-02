Rails.application.routes.draw do
  devise_for :users

  root "dashboard#index"
  get "dashboard", to: "dashboard#index"

  resources :transactions, only: [:new, :create, :edit, :update, :destroy], controller: 'finance'
  get "finance", to: "finance#index"
  get "finance/new", to: "finance#new"
end