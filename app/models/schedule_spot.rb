class ScheduleSpot < ApplicationRecord
  belongs_to :plan_schedule

  # with_options presence: true do
  #   validates :spot
  #   validates :time
  # end

end
