Rails.application.routes.draw do
  get 'debts/index'
  get 'debts/new'
  get 'debts/create'
  get 'debts/edit'
  get 'debts/update'
  get 'debts/destroy'
  get 'debts/pay'
  get 'savings_goals/index'
  get 'savings_goals/new'
  get 'savings_goals/create'
  get 'savings_goals/edit'
  get 'savings_goals/update'
  get 'savings_goals/destroy'
  get 'savings_goals/deposit'
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
  resources :savings_goals, only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      post :deposit
    end
  end

  resources :debts, only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      post :pay
    end
  end
end