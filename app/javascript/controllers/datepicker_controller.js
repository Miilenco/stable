import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["startDate", "endDate", "totalCost"];
  static values = { priceAtBooking: Number };

  connect() {
    flatpickr(this.startDateTarget, {
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      minDate: "today",
      onChange: () => this.calculateCost()
    });

    flatpickr(this.endDateTarget, {
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      minDate: "today",
      onChange: () => this.calculateCost()
    });
  }

  calculateCost() {
    const startDate = this.startDateTarget.value ? new Date(this.startDateTarget.value) : null;
    const endDate = this.endDateTarget.value ? new Date(this.endDateTarget.value) : null;

    if (startDate && endDate && endDate >= startDate) {
      const duration = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1; // Convert ms to days
      const totalCost = duration * this.priceAtBookingValue;

      this.totalCostTarget.value = totalCost.toFixed(2); // Update the total cost input field
    } else {
      this.totalCostTarget.value = 0;
    }
  }
}
