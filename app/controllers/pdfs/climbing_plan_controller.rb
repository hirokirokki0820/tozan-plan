module Pdfs
  class ClimbingPlanController < ApplicationController
    def index
      @plan = Plan.find(params[:plan_id])
      respond_to do |format|
        format.pdf do
          climbing_plan = Pdfs::ClimbingPlan.new(@plan).render
          send_data climbing_plan,
            filename: "#{@plan.destination}_登山計画書.pdf",
            type: 'application/pdf',
            disposition: 'inline' # 外すとダウンロード
        end
      end
    end
  end
end
