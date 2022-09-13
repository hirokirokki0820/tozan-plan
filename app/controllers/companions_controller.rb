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
    @address_book = AddressBook.new
    @address_book.user = current_user
  end

  # GET /companions/1/edit
  def edit
  end

  # POST /companions or /companions.json
  def create
    @companion = Companion.new(companion_params)
    @companion.plan = @plan

    if @plan.companions.length < 6 # @companion の登録上限（最大６人まで）
      if @companion.add_address == "1" # 「アドレス帳に保存する」にチェックを入れた時の処理
        if @companion.save
          redirect_to new_user_add_address_path(user_id: current_user.id, companion_id: @companion.id), notice: "登山者の登録、およびアドレス帳への登録が完了しました"
          # ↑ add_addresses_controller.rb の newアクションにリダイレクト(user_id と companion_id をクリエパラメータで渡す)
        else
          render :new, status: :unprocessable_entity
        end
      else # 通常の保存処理
        if @companion.save
          redirect_to @plan, notice: "登山者が登録されました"
        else
          render :new, status: :unprocessable_entity
        end
      end
    else # @companion の登録上限に達した時の処理
      redirect_to @plan, alert: "最大登録数は6人までです"
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
      params.require(:companion).permit(:full_name, :role, :birthday, :age, :gender, :address, :phone_number, :emergency_contact, :emergency_number, :add_address, :selected_id)
    end

    def address_book_params
      params.require(:address_book).permit(:full_name, :birthday, :age, :gender, :address, :phone_number, :emergency_contact, :emergency_number)
    end

    def require_same_user
      if current_user != @plan.user
        flash[:alert] = "ユーザーご本人以外のアクセスは禁止されています"
        redirect_to root_path
      end
    end
end
