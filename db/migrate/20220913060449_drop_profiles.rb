class DropProfiles < ActiveRecord::Migration[7.0]
  def change
    drop_table :profiles do |t|
      t.string :full_name
      t.string :gender
      t.date :birthday
      t.integer :age
      t.string :address
      t.string :phone_number
      t.string :emergency_contact
      t.string :emergency_number
      t.belongs_to :user, index: { unique: true }, foreign_key: :true, type: :string

      t.timestamps
    end
  end
end
