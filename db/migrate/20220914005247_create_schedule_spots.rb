class CreateScheduleSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :schedule_spots do |t|
      t.string :spot
      t.time :time
      t.belongs_to :plan_schedule, index: true, foreign_key: :true

      t.timestamps
    end
  end
end
