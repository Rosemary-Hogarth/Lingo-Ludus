import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
  static targets = [
    "body",
    "checkbox",
    "h1",
    "text",
    "definitionContainer",
    "difficultyDropdown",
    "categoryDropdown",
    "input",
  ];

  connect() {
    console.log("dark mode connected");
    this.checkDarkModeHome();
    this.checkDarkModePlay();
  }

  toggleDarkMode() {
    console.log("dark mode toggled");
    const isDarkMode = this.bodyTarget.classList.toggle("dark-mode");
    localStorage.setItem("darkMode", isDarkMode);
  }

  checkDarkModeHome() {
    const isDarkMode = localStorage.getItem("darkMode") === "true";
    if (this.hasH1Target) {
      if (isDarkMode) {
        this.checkboxTarget.checked = true;
        this.bodyTarget.classList.add("dark-mode");
        this.h1Target.style.color = "#FFFCF9"
        this.textTarget.style.color = "#FFFCF9";
      } else {
        this.checkboxTarget.checked = false;
        this.bodyTarget.classList.remove("dark-mode");
        this.h1Target.style.color = "black";
        this.textTarget.style.color = "black";
      }
    }
   }

   checkDarkModePlay() {
    const isDarkMode = localStorage.getItem("darkMode") === "true";
    if (isDarkMode) {
      this.checkboxTarget.checked = true;
      this.bodyTarget.classList.add("dark-mode");
      this.textTarget.style.color = "#FFFCF9";
      this.definitionContainerTarget.style.backgroundColor = "#FFFCF9";
      this.categoryDropdownTarget.classList.remove("bg-white");
      this.difficultyDropdownTarget.classList.remove("bg-white");
   } else {
      this.checkboxTarget.checked = false;
      this.bodyTarget.classList.remove("dark-mode");
      this.textTarget.style.color = "black";
      this.definitionContainerTarget.style.backgroundColor = "white";
      this.categoryDropdownTarget.classList.add("bg-white");
      this.difficultyDropdownTarget.classList.add("bg-white");
   }
  }
}
