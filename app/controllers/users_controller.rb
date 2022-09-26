class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy ]
  before_action :require_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:show, :edit, :update, :destroy]
  before_action :require_verified_user, only: [:edit, :update, :destroy]
  # protect_from_forgery except: :is_registered?

  def index
    # @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:notice] = "アカウント有効化メールを送信しました。メールが届きましたら、記載されているリンクをクリックしてアカウントを有効化してください。"
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: "アカウント情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
      redirect_to root_url, notice: "ユーザーアカウントを削除しました", status: :see_other
  end

  # メールアドレスがすでに登録されているかどうかチェックする
  def is_registered?
    user = User.find_by(email: params[:email]) # クリエパラメータに埋め込んだEメールアドレスからユーザーを検索（いなければnull)
    render json: user
  end

  private
    def set_user
      @user = User.find_by(id: current_user.id) if logged_in?
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def require_same_user
      if current_user != @user
        flash[:alert] = "ユーザーご本人以外のアクセスは禁止されています"
        redirect_to @user
      end
    end

    def require_verified_user
      if logged_in? && (current_user.email == "guest@example.com")
        redirect_to root_url, alert: "ゲストユーザーのアカウント編集・削除はできません"
      end
    end
end
