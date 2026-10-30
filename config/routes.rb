Rails.application.routes.draw do
  devise_for :users

  root "dashboard#index"
  get "dashboard", to: "dashboard#index"
  
  get "finance", to: "finance#index"
  get "finance/new", to: "finance#new"
  post "finance", to: "finance#create"
end