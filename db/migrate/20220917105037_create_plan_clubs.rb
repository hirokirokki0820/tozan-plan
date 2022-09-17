class CreatePlanClubs < ActiveRecord::Migration[7.0]
  def change
    create_table :plan_clubs do |t|
      t.string :belongs_to
      t.string :group_name
      t.string :representative_name
      t.string :representative_address
      t.string :representative_number
      t.string :emergency_contact
      t.string :address
      t.string :phone_number
      t.string :rescue_system
      t.belongs_to :plan, index: true, foreign_key: :true, type: :string

      t.timestamps
    end
  end
end
