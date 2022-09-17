class PlanEscape < ApplicationRecord
  belongs_to :plan

  validates :escape_route, presence: true
end
