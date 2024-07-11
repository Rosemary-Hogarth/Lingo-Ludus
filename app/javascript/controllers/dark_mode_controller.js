import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="dark-mode"
export default class extends Controller {
  static targets = [
    "checkbox",
  ];
  connect() {
    console.log("dark mode connected");
    this.checkDarkMode();
    console.log(this.element)
  }
  toggleDarkMode() {
    console.log("dark mode toggled");
    const isDarkMode = this.element.classList.toggle("dark-mode");
    localStorage.setItem("darkMode", isDarkMode);
    document.body.dispatchEvent(new CustomEvent('darkModeChanged', { detail: { isDarkMode: isDarkMode } }));
  }
  checkDarkMode() {
    const isDarkMode = localStorage.getItem("darkMode") === "true";
    if (isDarkMode) {
      this.element.classList.add("dark-mode")
      this.checkboxTarget.checked = true
    } else {
      this.element.classList.remove("dark-mode")
    }
   }
}
