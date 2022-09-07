class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans, id: :string do |t|
      t.string :destination
      t.string :submit_to
      t.date :start_day
      t.date :last_day
      t.belongs_to :user, foreign_key: :true, type: :string

      t.timestamps
    end
  end
end
