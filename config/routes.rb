Rails.application.routes.draw do
  root "main#top"

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users, except: [:new] do
    resources :profiles, only: [:new, :edit, :create, :update]
    collection do
      resources :details, only: [:edit, :update]
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :plans do
    # pdf 出力
    scope module: :pdfs do
      resources :climbing_plan, only: [:index]
    end
    resources :companions
  end

  # フォーマット用pdf 出力
  scope module: :pdfs do
    resources :sample_format, only: [:index]
  end

end
