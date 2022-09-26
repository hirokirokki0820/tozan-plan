class CopyPlansController < ApplicationController
  before_action :set_plan, only: [:create]

  def create
    # @plan のコピー
    new_plan = Plan.create!(
                    destination: @plan.destination + "(コピー)",
                    submit_to: @plan.submit_to,
                    start_day: @plan.start_day, last_day: @plan.last_day,
                    user_id: @plan.user_id
    )

    # 登山者情報のコピー
    if @plan.companions.present?
      @plan.companions.each do |companion|
        Companion.create!(
                  role: companion.role,
                  full_name:companion.full_name,
                  age:companion.age,
                  birthday: companion.birthday,
                  gender: companion.gender,
                  address: companion.address,
                  phone_number: companion.phone_number,
                  emergency_contact: companion.emergency_contact,
                  emergency_number: companion.emergency_number,
                  plan_id: new_plan.id
        )
      end
    end

    # 行動スケジュールのコピー
    if @plan.plan_schedules.present?
      @plan.plan_schedules.each do |schedule|
        new_schedule = PlanSchedule.create!(
                        date: schedule.date,
                        plan_id: new_plan.id
        )
        if schedule.schedule_spots.present?
          schedule.schedule_spots.each do |spot|
            ScheduleSpot.create!(
                        spot: spot.spot,
                        time: spot.time,
                        plan_schedule_id: new_schedule.id
            )
          end
        end
      end
    end

    # エスケープルートのコピー
    if @plan.plan_escape.present?
      PlanEscape.create!(
                  escape_route: @plan.plan_escape.escape_route,
                  plan_id: new_plan.id
      )
    end

    # 山岳会・サークル情報のコピー
    if @plan.plan_club.present?
      PlanClub.create!(
                  belongs_to: @plan.plan_club.belongs_to,
                  group_name: @plan.plan_club.group_name,
                  representative_name: @plan.plan_club.representative_name,
                  representative_address: @plan.plan_club.representative_address,
                  representative_number: @plan.plan_club.representative_number,
                  emergency_contact: @plan.plan_club.emergency_contact,
                  address: @plan.plan_club.address,
                  phone_number: @plan.plan_club.phone_number,
                  rescue_system: @plan.plan_club.rescue_system,
                  plan_id: new_plan.id
      )
    end

    # 持ち物情報のコピー
    if @plan.plan_equipment.present?
      PlanEquipment.create!(
                  food: @plan.plan_equipment.food,
                  emergency_food: @plan.plan_equipment.emergency_food,
                  camp_equipment: @plan.plan_equipment.camp_equipment,
                  climbing_equipment: @plan.plan_equipment.climbing_equipment,
                  wireless: @plan.plan_equipment.wireless,
                  others: @plan.plan_equipment.others,
                  plan_id: new_plan.id
      )
    end

    redirect_to mypage_path
  end

private
  def set_plan
    @plan = Plan.find(params[:plan_id])
  end
end
