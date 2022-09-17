class SchedulesForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :date, :date
  # attribute :schedule, :string
  attribute :spots
  attribute :spot, :string
  attribute :time, :time
  attribute :plan_id, :string

  with_options presence: true do
    validates :date
    # validates :spot
    # validates :time
  end

  # 作成・更新に応じてフォームのアクションをPOST・PATCHに切り替える
  delegate :persisted?, to: :@schedule


  # 編集で入力された値（attributes）があれば、既に存在するdefault_attributesにマージして更新している
  def initialize(attributes = {}, schedule: PlanSchedule.new)
    @schedule = schedule
    @spots = schedule.schedule_spots
    new_attributes = default_attributes.merge(attributes)
    super(new_attributes)
  end

def save
  return false if invalid?

  ActiveRecord::Base.transaction do
    schedule = PlanSchedule.new(schedule_params)
    schedule.save!
    spots.each do |spot|
      if !(spot["spot"] == "" && spot["time"] == "")
        ScheduleSpot.create!(spot: spot["spot"], time: spot["time"], plan_schedule_id: schedule.id)
      end
    end
  end

  true
end

def update
  return false if invalid?
  ActiveRecord::Base.transaction do
    @schedule.update!(schedule_params)
    # @spots はDBから取得した値（オブジェクト）, spots は編集フォームから取得した値（配列）
    if @spots.length == spots.length
      @spots.each_with_index do |spot, index|
        if spots[index]["spot"] == ""
          spot.destroy
        else
          spot.update!(spot: spots[index]["spot"], time: spots[index]["time"])
        end
      end
    elsif @spots.length < spots.length
      # 既存データと編集後データの差分
      diff = spots.length - @spots.length
      # 既存のデータを更新
      @spots.each_with_index do |spot, index|
        if spots[index]["spot"] == ""
          spot.destroy
        else
          spot.update!(spot: spots[index]["spot"], time: spots[index]["time"])
        end
      end
      # 追加分（既存データとの差分）のデータを登録
      spots.each_with_index do |spot, index|
        if index >= (spots.length - diff)
          if !(spot["spot"] == "")
            ScheduleSpot.create!(spot: spot["spot"], time: spot["time"], plan_schedule_id: @schedule.id)
          end
        end
      end
    end

    # @spots.each(&:update!)
  end
end

# アクションのURLを適切な場所（posts_pathやpost_path(:id)）に切り替える
# def to_model
#   @schedule
# end

private


  def schedule_params
    {
      date: date,
      plan_id: plan_id
    }
  end


  # 既存の値を取得
  def default_attributes
    {
      # p "いいいいいいいいいいいいいいいいいいいいいいいいいいいいーーー: #{}"
      date: @schedule.date,
      plan_id: @schedule.plan_id,
      spots: @schedule.schedule_spots
      # spot: @schedule.schedule_spots[0]["spot"],
      # time: @schedule.schedule_spots[0]["time"]
    }
  end


end
