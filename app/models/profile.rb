class Profile < ApplicationRecord
  attr_accessor :add_address
  encrypts :full_name, :gender, :birthday, :age, :address, :phone_number, :emergency_contact, :emergency_number
  belongs_to :user

  with_options presence: true do
    validates :full_name
    validates :age
    validates :address
    validates :phone_number
    validates :emergency_contact
    validates :emergency_number
  end
end
