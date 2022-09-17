class CreatePlanSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :plan_schedules do |t|
      t.date :date
      t.text :schedule
      t.belongs_to :plan, index: true, foreign_key: :true, type: :string

      t.timestamps
    end
  end
end
