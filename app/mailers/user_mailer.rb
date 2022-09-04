class UserMailer < ApplicationMailer

  # アカウント有効化メール
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウントの有効化"
  end

  # パスワードリセット用メール
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードの再設定"
  end
end
