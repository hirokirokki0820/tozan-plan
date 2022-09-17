class PlanEquipmentsController < ApplicationController
  before_action :set_plan
  before_action :set_equipment, only: %i[ edit update destroy ]
  before_action :require_user
  before_action :require_same_user

  def new
    @equipment = PlanEquipment.new
  end

  def edit
  end

  def create
    if @plan.plan_equipment.nil?
      @equipment = PlanEquipment.new(equipment_params)
      @equipment.plan = @plan
      if @equipment.save
        redirect_to @plan, notice: "持ち物情報が登録されました"
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to @plan, alert: "すでに登録済みです"
    end
  end

  def update
    if @equipment.update(equipment_params)
      redirect_to @plan, notice: "持ち物情報が更新されました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @equipment.destroy
    redirect_to @plan, notice: "持ち物情報が削除されました", status: :see_other
  end

  private
    def set_plan
      @plan = Plan.find(params[:plan_id])
    end

    def set_equipment
      @equipment = PlanEquipment.find(params[:id])
    end

    def equipment_params
      params.require(:plan_equipment).permit(:food, :emergency_food, :camp_equipment, :climbing_equipment, :wireless, :others)
    end

    def require_same_user
      if current_user != @plan.user
        flash[:alert] = "ユーザーご本人以外のアクセスは禁止されています"
        redirect_to root_path
      end
    end
end
