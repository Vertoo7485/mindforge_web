Rails.application.routes.draw do
  get 'budgets/index'
  get 'budgets/new'
  get 'budgets/create'
  get 'budgets/edit'
  get 'budgets/update'
  get 'budgets/destroy'
  devise_for :users

  root "dashboard#index"
  get "dashboard", to: "dashboard#index"

  resources :transactions, only: [:new, :create, :edit, :update, :destroy], controller: 'finance'
  get "finance", to: "finance#index"
  get "finance/new", to: "finance#new"
  resources :budgets, only: [:index, :new, :create, :edit, :update, :destroy]
end