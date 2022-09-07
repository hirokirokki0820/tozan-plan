class AddProfileInfoToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :birthday, :date
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :address, :string
    add_column :users, :phone_number, :string
    add_column :users, :emergency_contact, :string
    add_column :users, :emergency_number, :string
  end
end
