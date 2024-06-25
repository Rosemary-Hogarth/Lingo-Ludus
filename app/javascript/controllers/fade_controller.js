import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Hello there");
    this.element.classList.add('fade-in');
    requestAnimationFrame(() => {
      this.element.classList.add('show');
    });
  }
}
