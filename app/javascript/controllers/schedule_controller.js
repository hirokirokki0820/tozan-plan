import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="schedule"
export default class extends Controller {

  static targets = [
                    "schedule",
                    "add_field"
                    ]

  addScheduleField() {

  }
}
