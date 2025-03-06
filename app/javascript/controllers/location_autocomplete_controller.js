// app/javascript/controllers/location_autocomplete_controller.js
import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="location-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }
  static targets = ["location"]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address"
    })
    this.geocoder.addTo(this.element)

    // Listen for a selected result
    this.geocoder.on("result", event => this.#setInputValue(event))
    // Listen for when the geocoder is cleared
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  #setInputValue(event) {
    // Update the input with the full place name
    this.locationTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    // Clear the input field
    this.locationTarget.value = ""
  }
}
