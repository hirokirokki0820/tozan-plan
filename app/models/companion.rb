class Companion < ApplicationRecord
  attr_accessor :add_address, :selected_id
  encrypts :full_name, :gender, :address, :phone_number, :emergency_contact, :emergency_number
  belongs_to :plan

  with_options presence: true do
    validates :full_name
    validates :age
    validates :address
    validates :phone_number
    validates :emergency_contact
    validates :emergency_number
  end
end
