import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()

// This is a Stimulus controller that initializes flatpickr on the element it's connected to
export default class extends Controller {
  connect() {
    flatpickr(this.element)
  }
}
