// NOT IN USE CURRENTLY
// This controller is not in use currently. It was created to format currency inputs, but it was not used in the final version of the app.
// It is kept here for future reference.

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  formatCurrency() {
    let value = this.inputTarget.value.replace(/[^0-9.]/g, ""); // Keep only numbers & decimal points

    // Ensure only one decimal point and format properly
    if (value.includes(".")) {
      let parts = value.split(".");
      value = parts[0] + "." + parts.slice(1).join("").replace(/\./g, ""); // Remove extra dots
    }

    this.inputTarget.value = value;
  }
}
