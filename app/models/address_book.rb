class AddressBook < ApplicationRecord
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

  private
    # @companion情報からアドレス帳の作成
    def self.create_address_book(companion, user)
      create!(full_name: companion.full_name,
              gender: companion.gender,
              birthday: companion.birthday,
              age: companion.age,
              address: companion.address,
              phone_number: companion.phone_number,
              emergency_contact: companion.emergency_contact,
              emergency_number: companion.emergency_number,
              user_id: user.id
              )
    end
end
