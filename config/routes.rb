Rails.application.routes.draw do
  root "main#top"

  get "signup", to: "users#new"
  get "mypage", to: "users#show"
  get "mypage/account_setting", to: "users#edit"
  delete "account_delete", to: "users#destroy"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users, only: [:index, :create, :update] do
    resources :address_books
    resources :add_addresses, only: [:new]
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :plans do
    # pdf 出力
    scope module: :pdfs do
      resources :climbing_plan, only: [:index]
    end
    resources :companions
    resources :plan_schedules
    resources :schedule_spots
  end

  # フォーマット用pdf 出力
  scope module: :pdfs do
    resources :sample_format, only: [:index]
  end

end
