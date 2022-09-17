class PlanEscapesController < ApplicationController
  before_action :set_plan
  before_action :set_escape, only: %i[ edit update destroy ]
  before_action :require_user
  before_action :require_same_user

  def new
    @escape = PlanEscape.new
  end

  def edit
  end

  def create
    if @plan.plan_escape.nil?
      @escape = PlanEscape.new(escape_params)
      @escape.plan = @plan
      if @escape.save
        redirect_to @plan, notice: "持ち物情報が登録されました"
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to @plan, alert: "すでに登録済みです"
    end
  end

  def update
    if @escape.update(escape_params)
      redirect_to @plan, notice: "持ち物情報が更新されました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @escape.destroy
    redirect_to @plan, notice: "持ち物情報が削除されました", status: :see_other
  end

  private
    def set_plan
      @plan = Plan.find(params[:plan_id])
    end

    def set_escape
      @escape = PlanEscape.find(params[:id])
    end

    def escape_params
      params.require(:plan_escape).permit(:escape_route)
    end

    def require_same_user
      if current_user != @plan.user
        flash[:alert] = "ユーザーご本人以外のアクセスは禁止されています"
        redirect_to root_path
      end
    end
end
