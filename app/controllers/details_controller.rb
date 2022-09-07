class DetailsController < ApplicationController
  before_action :set_user
  before_action :require_user
  before_action :require_same_user

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "プロフィールが更新されました"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:full_name, :birthday, :age, :gender, :address, :phone_number, :emergency_contact, :emergency_number)
    end

    def require_same_user
      if current_user != @user
        flash[:alert] = "許可されていない操作です。プロフィールの編集、削除は作成者ご自身のみ可能です。"
        redirect_to @user
      end
    end
end
