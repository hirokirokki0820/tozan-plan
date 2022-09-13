class RemoveSomeColumnsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :full_name, :string
    remove_column :users, :birthday, :date
    remove_column :users, :age, :integer
    remove_column :users, :gender, :string
    remove_column :users, :address, :string
    remove_column :users, :phone_number, :string
    remove_column :users, :emergency_contact, :string
    remove_column :users, :emergency_number, :string
  end
end
