class Plan < ApplicationRecord
  before_create :set_plan_id
  has_many :companions, dependent: :destroy
  has_many :plan_schedules, dependent: :destroy
  belongs_to :user

  validates :destination, presence: true, length: { maximum: 30 }
  validates :start_day, presence: true
  validates :last_day, presence: true

  private
  def set_plan_id
    while self.id.blank? || Plan.find_by(id: self.id).present? do
      self.id = SecureRandom.urlsafe_base64
    end
  end
end
