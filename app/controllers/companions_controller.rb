class CompanionsController < ApplicationController
  before_action :set_plan
  before_action :set_companion, only: %i[ show edit update destroy ]
  before_action :require_user
  before_action :require_same_user

  # GET /companions or /companions.json
  def index
    @companions = Companion.all
  end

  # GET /companions/1 or /companions/1.json
  def show
  end

  # GET /companions/new
  def new
    @companion = Companion.new
  end

  # GET /companions/1/edit
  def edit
  end

  # POST /companions or /companions.json
  def create
    @companion = Companion.new(companion_params)
    @companion.plan = @plan
    if @companion.save
      redirect_to @plan, notice: "登山者が登録されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /companions/1 or /companions/1.json
  def update
    if @companion.update(companion_params)
        redirect_to @plan, notice: "登山者名簿が更新されました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /companions/1 or /companions/1.json
  def destroy
    @companion.destroy
    redirect_to @plan, notice: "登山者名簿が1件削除されました", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:plan_id])
    end

    def set_companion
      @companion = Companion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def companion_params
      params.require(:companion).permit(:full_name, :role, :birthday, :age, :gender, :address, :phone_number, :emergency_contact, :emergency_number)
    end

    def require_same_user
      if current_user != @plan.user
        flash[:alert] = "許可されていない操作です。プロフィールの編集、削除は作成者ご自身のみ可能です。"
        redirect_to root_path
      end
    end
end
