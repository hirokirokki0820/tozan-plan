class PlanClubsController < ApplicationController
  before_action :set_plan
  before_action :set_club, only: %i[ edit update destroy ]
  before_action :require_user
  before_action :require_same_user

  def new
    @club = PlanClub.new
  end

  def edit
  end

  def create
    if @plan.plan_club.nil?
      @club = PlanClub.new(club_params)
      @club.plan = @plan
      if @club.save
        redirect_to @plan, notice: "山岳会・サークルが登録されました"
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to @plan, alert: "すでに登録済みです"
    end
  end

  def update
    if @club.update(club_params)
      redirect_to @plan, notice: "山岳会・サークル情報が更新されました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @club.destroy
    redirect_to @plan, notice: "山岳会・サークル情報が削除されました", status: :see_other
  end

  private
    def set_plan
      @plan = Plan.find(params[:plan_id])
    end

    def set_club
      @club = PlanClub.find(params[:id])
    end

    def club_params
      params.require(:plan_club).permit(:belongs_to, :group_name, :representative_name, :representative_address, :representative_number, :address, :phone_number, :emergency_contact, :rescue_system)
    end

    def require_same_user
      if current_user != @plan.user
        flash[:alert] = "ユーザーご本人以外のアクセスは禁止されています"
        redirect_to root_path
      end
    end
end
