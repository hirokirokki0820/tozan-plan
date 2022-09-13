class ProfilesController < ApplicationController
  before_action :set_profile
  before_action :require_user
  # before_action :require_same_user

  def new
    @profile = Profile.new
  end

  def edit
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = @user
    if @profile.save
      flash[:notice] = "個人情報が登録されました"
      redirect_to @user
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    # @profile = Profile.new(profile_params)
    if @profile.update(profile_params)
      flash[:notice] = "個人情報が更新されました"
      redirect_to @profile.user
    else
      render "edit", status: :unprocessable_entity
    end
  end


  private
    def set_profile
      @user = User.find(params[:user_id])
      @profile = @user.profile
    end

    def profile_params
      params.require(:profile).permit(:full_name, :gender, :birthday, :age, :address, :phone_number, :emergency_contact, :emergency_number, :add_address)
    end

    def require_same_user
      if current_user != @profile.user
        flash[:alert] = "許可されていない操作です。プロフィールの編集、削除は作成者ご自身のみ可能です。"
        redirect_to current_user
      end
    end
end
