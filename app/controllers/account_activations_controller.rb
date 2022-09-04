class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && !user.activation_expired? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:notice] = "アカウントが有効化されました"
      redirect_to user
    else
      flash[:error] = "このリンクは無効、もしくは有効期限切れです。お手数ですが、再登録の方よろしくお願いします。"
      user.destroy if user
      redirect_to signup_url
    end
  end
end
