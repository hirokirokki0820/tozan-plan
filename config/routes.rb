Rails.application.routes.draw do
  get 'users/show'
  get 'users/new'
  root "home#index"
  get "signup", to: "users#new"
  resources :users, except: [:new]
end
