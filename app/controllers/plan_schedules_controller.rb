class PlanSchedulesController < ApplicationController
  before_action :set_plan
  before_action :set_schedule, only: %i[ index show edit update destroy ]
  before_action :require_user

  def index
    @schedules = PlanSchedule.all
  end

  def show
  end

  def new
    @schedules_form = SchedulesForm.new
    # @schedule.schedule_spots.build
  end

  def edit
    @schedules_form = SchedulesForm.new(schedule: @schedule)
  end

  def create
    @schedules_form = SchedulesForm.new(schedule_params)
    @schedules_form.plan_id = @plan.id
    if @plan.plan_schedules.length < 5 # @schedule の登録上限（最大5件まで）
      if @schedules_form.save
        redirect_to @plan, notice: "行動スケジュールが追加されました"
      else
        @schedules_form = SchedulesForm.new(schedule_params)
        @schedules_form.errors.add(:date, "※必須項目です")
        render :new, status: :unprocessable_entity
      end
    else # @companion の登録上限に達した時の処理
      redirect_to @plan, alert: "最大登録数は5件までです"
    end
  end

  def update
    @schedules_form = SchedulesForm.new(schedule_params, schedule: @schedule)
    if @schedule.schedule_spots.length < 11 # @schedule の登録上限（最大5件まで）
      if @schedules_form.update
        redirect_to @plan, notice: "行動スケジュールが更新されました"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to @plan, alert: "最大登録数は10件までです"
    end
  end

  def destroy
    @schedule.destroy
    redirect_to @plan, notice: "行動スケジュールが1件削除されました", status: :see_other
  end

  private
    def set_plan
      @plan = Plan.find(params[:plan_id])
    end

    def set_schedule
      @schedule = PlanSchedule.find(params[:id])
    end

    def schedule_params
      params.require(:schedules_form).permit(:date, :plan_id, [ spots:[:spot, :time] ])
    end

    def spot_params
      params.require(:schedules_form).permit([spots: [:spot, :time]])
    end

    def require_same_user
      if current_user != @plan.user
        flash[:alert] = "ユーザーご本人以外のアクセスは禁止されています"
        redirect_to root_path
      end
    end
end
