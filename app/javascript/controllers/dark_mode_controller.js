import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
  static targets = [
    "body",
    "container",
    "checkbox",
    "h1",
    "text",
    "definitionContainer",
    "difficultyDropdown",
    "categoryDropdown",
    "input",
  ];

  connect() {
    console.log("dark mode connected")
    this.checkDarkMode();
  }

  toggleDarkMode() {
    console.log("dark mode toggled");
    const isDarkMode = document.body.classList.toggle("dark-mode");
    localStorage.setItem("darkMode", isDarkMode);
    this.definitionContainerTarget.style.backgroundColor = "#FFFCF9";
    this.categoryDropdownTarget.classList.toggle("bg-white")
    this.inputTargets.forEach(input => {
      input.classList.add("dark-mode");
    });
  }

  checkDarkMode() {
    const isDarkMode = localStorage.getItem("darkMode") === "true";
    if (isDarkMode) {
      this.checkboxTarget.checked = true;
      this.bodyTarget.classList.add("dark-mode");
      this.containerTarget.classList.add("dark-mode");
      this.h1Target.style.color = "#FFFCF9"
      this.textTarget.style.color = "#FFFCF9";
      this.definitionContainerTarget.style.backgroundColor = "#FFFCF9";
      this.categoryDropdownTarget.classList.remove("bg-white");
      this.difficultyDropdownTarget.classList.remove("bg-white");
      // this.inputTargets.forEach(input => {
      //   input.classList.add("dark-mode");
      // });
    } else {
      this.h1Target.style.color = "black";
      this.textTarget.style.color = "black";
      this.definitionContainerTarget.style.backgroundColor = "white";
      this.categoryDropdownTarget.style.backgroundColor = "white"
      this.categoryDropdownTarget.classList.add("bg-white");
      this.difficultyDropdownTarget.classList.add("bg-white");
      // this.inputTargets.forEach(input => {
      //   input.classList.remove("dark-mode");
      // });
    }

  }
}
