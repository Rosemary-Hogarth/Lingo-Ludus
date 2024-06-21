import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guess"
export default class extends Controller {
  connect() {
    console.log("Hello from our first Stimulus controller");
  }
  static targets = ["input"];

  check(event) {

    console.log("clicked");

    
  }
}
