class PlanEquipment < ApplicationRecord
  belongs_to :plan

  with_options presence: true do
    validates :food
    validates :emergency_food
  end
end
