class PlanSchedule < ApplicationRecord
  has_many :schedule_spots, dependent: :destroy
  belongs_to :plan

  # accepts_nested_attributes_for :schedule_spots, allow_destroy: true

  validates :date, presence: true

end
