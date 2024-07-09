import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="light-navbar"
export default class extends Controller {
  static targets = ["navbar", "name", "link1", "link2", "link3", "link4" ]
  connect() {
    console.log("Light navbar connected")
    console.log("Navbar target:", this.navbarTarget)
    console.log("Name target:", this.nameTarget)
    console.log("Has navbar target:", this.hasNavbarTarget)
    console.log("Has name target:", this.hasNameTarget)
    this.checkDarkModeNavbar();
  }

  checkDarkModeNavbar() {
    const isDarkMode = localStorage.getItem("darkMode") === "true";

    if (this.hasNavbarTarget) {
      if (isDarkMode) {
        this.navbarTarget.classList.add("white");
        this.nameTarget.classList.add("black", "heavy-font");
        this.link1Target.classList.add("black")
        this.link2Target.classList.add("black")
        this.link3Target.classList.add("black")
        this.link4Target.classList.add("black")
      } else {
        this.navbarTarget.classList.remove("white");
        this.nameTarget.classList.remove("black", "heavy-font");
        this.link1Target.classList.remove("black")
        this.link2Target.classList.remove("black")
        this.link3Target.classList.remove("black")
        this.link4Target.classList.remove("black")
      }
    }
  }
}
