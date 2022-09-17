class CreatePlanEquipments < ActiveRecord::Migration[7.0]
  def change
    create_table :plan_equipments do |t|
      t.string :food
      t.string :emergency_food
      t.string :camp_equipment
      t.string :climbing_equipment
      t.string :wireless
      t.string :others
      t.belongs_to :plan, index: true, foreign_key: :true, type: :string

      t.timestamps
    end
  end
end
