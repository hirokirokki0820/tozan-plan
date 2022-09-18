class MainController < ApplicationController
  def top
    redirect_to mypage_path if logged_in?
  end
end
