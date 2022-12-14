class GuestSessionsController < ApplicationController
  def create
    user = User.find_or_create_by(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
    log_in user
    flash[:notice] = "ゲストユーザーとしてログインしました"
    redirect_to root_path
  end
end
