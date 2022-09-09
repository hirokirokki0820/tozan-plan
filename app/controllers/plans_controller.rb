class PlansController < ApplicationController
  before_action :set_plan, only: %i[ show edit update destroy ]
  before_action :require_same_user, only: %i[ show edit update destroy ]

  def index
    @plans = Plan.all
  end

  def show
  end

  def new
    @plan = Plan.new
  end

  def edit
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user = current_user
    if @plan.save
      redirect_to @plan, notice: '新規計画書を追加しました。引き続き、計画書の作成を進めてください。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @plan.update(plan_params)
      redirect_to current_user, notice: '登山計画書が更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @plan.destroy
    redirect_to current_user, notice: '計画書が削除されました', status: :see_other
  end

  private
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def plan_params
      params.require(:plan).permit(:destination, :submit_to, :start_day, :last_day)
    end

    def require_same_user
      if current_user != @plan.user
        flash[:alert] = "異なるユーザーからのアクセスは禁止されています"
        redirect_to root_path
      end
    end
end
