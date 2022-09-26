Rails.application.routes.draw do
  root "main#top"

  # 新規登録
  get "signup", to: "users#new"

  # メールアドレス登録済みチェック
  post "signup/check_email", to: "users#is_registered?"

  # マイページ
  get "mypage", to: "users#show"
  get "mypage/account_setting", to: "users#edit"
  delete "account_delete", to: "users#destroy"

  # ログイン、ログアウト
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # ゲストログイン
  post "guest_login", to: "guest_sessions#create"

  # ユーザー
  resources :users, only: [:index, :create, :update] do
    resources :address_books
    resources :add_addresses, only: [:new]
  end

  # アカウント有効化、パスワード再設定
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # 登山計画書
  resources :plans do
    # 計画書（PDF）出力
    scope module: :pdfs do
      resources :climbing_plan, only: [:index]
    end
    resources :companions
    resources :plan_schedules
    resources :schedule_spots
    resources :plan_clubs
    resources :plan_equipments
    resources :plan_escapes
    resources :copy_plans, only: [:create]
  end

  # 計画書のサンプル(PDF)
  scope module: :pdfs do
    resources :sample_format, only: [:index]
  end

end
