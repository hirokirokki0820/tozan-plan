class PlanClub < ApplicationRecord
  belongs_to :plan
  encrypts :representative_name, :representative_address, :representative_number, :address, :phone_number, :emergency_contact

  with_options presence: true do
    validates :belongs_to
    validates :representative_name
    validates :representative_address
    validates :representative_number
    validates :address
    validates :phone_number
    validates :emergency_contact
    validates :rescue_system
  end
end
