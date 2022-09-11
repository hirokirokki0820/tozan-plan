class Profile < ApplicationRecord
  encrypts :full_name, :gender, :birthday, :age, :address, :phone_number, :emergency_contact, :emergency_number
  belongs_to :user
end
