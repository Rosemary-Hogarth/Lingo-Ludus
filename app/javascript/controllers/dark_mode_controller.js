import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="dark-mode"
export default class extends Controller {
  static targets = [
    "body",
    "checkbox",
  ];
  connect() {
    console.log("dark mode connected");
    this.checkDarkMode();
  }
  toggleDarkMode() {
    console.log("dark mode toggled");
    const isDarkMode = this.bodyTarget.classList.toggle("dark-mode");
    localStorage.setItem("darkMode", isDarkMode);
    document.body.dispatchEvent(new CustomEvent('darkModeChanged', { detail: { isDarkMode: isDarkMode } }));
  }
  checkDarkMode() {
    const isDarkMode = localStorage.getItem("darkMode") === "true";
    if (isDarkMode) {
      this.bodyTarget.classList.add("dark-mode")
      this.checkboxTarget.checked = true
    } else {
      this.bodyTarget.classList.remove("dark-mode")
    }
   }
}
