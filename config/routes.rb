Rails.application.routes.draw do
  get 'habits/create'
  get 'habits/toggle'
  get 'habits/destroy'
  get 'planner/index'
  get 'planner/new'
  get 'planner/create'
  get 'planner/toggle'
  get 'planner/destroy'
  get 'consultant/index'
  get 'consultant/setup'
  get 'analytics/index'
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

  get "analytics", to: "analytics#index"
  get "consultant", to: "consultant#index"
  get "consultant/setup", to: "consultant#setup", as: :setup_consultant
  post "consultant/save_profile", to: "consultant#save_profile", as: :save_profile_consultant

  get "planner", to: "planner#index"
  get "planner/new", to: "planner#new", as: :new_task
  post "planner", to: "planner#create"
  patch "planner/:id/toggle", to: "planner#toggle", as: :toggle_task
  delete "planner/:id", to: "planner#destroy", as: :task

  post "habits", to: "habits#create"
  patch "habits/:id/toggle", to: "habits#toggle", as: :toggle_habit
  delete "habits/:id", to: "habits#destroy", as: :habit
end