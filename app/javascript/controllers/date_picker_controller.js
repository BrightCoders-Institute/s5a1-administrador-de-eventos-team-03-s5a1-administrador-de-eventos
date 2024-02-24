import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "dateFrom", "dateTo" ]

  connect() {
    console.log("DatePicker controller connected");
  }

  updateMinDate() {
    this.dateToTarget.min = this.dateFromTarget.value;
  }
}
