class CreatePlanEscapes < ActiveRecord::Migration[7.0]
  def change
    create_table :plan_escapes do |t|
      t.text :escape_route
      t.belongs_to :plan, index: true, foreign_key: :true, type: :string

      t.timestamps
    end
  end
end
