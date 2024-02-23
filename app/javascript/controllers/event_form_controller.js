import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["date", "reminder"]

  updateMaxDate() {
    let eventDateValue = this.dateTarget.value + "T00:00:00";
    let maxDate = new Date(eventDateValue);
    this.reminderTarget.max = maxDate.toISOString().slice(0, 16);
  }
}
