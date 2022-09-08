class CreateCompanions < ActiveRecord::Migration[7.0]
  def change
    create_table :companions do |t|
      t.string :role
      t.string :full_name
      t.string :gender
      t.integer :age
      t.date :birthday
      t.string :address
      t.string :phone_number
      t.string :emergency_contact
      t.string :emergency_number
      t.belongs_to :plan, foreign_key: :true, type: :string

      t.timestamps
    end
  end
end
