import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dark-dash"
export default class extends Controller {
  static targets = [ "firstContainer",
  "secondContainer",
  "scoreHeader",
  "thirdContainer",
  "fourthContainer",
  "leaderboardContainer",
  "leaderNavbar",
  "header",
  "firstContainerHeader",
  "secondContainerHeader",
  "recentGamesHeader",
  "table",
  "leaderboardCard",
  "navLink"
  ]

  connect() {
    console.log("Hi from dark-dash controller")
    if (this.hasFirstContainerTarget) {
    this.checkDarkModeDash();
    }
  }


  checkDarkModeDash() {
    console.log("checkDarkModeDash called");

    // Check if dark mode is enabled based on localStorage
    const isDarkMode = localStorage.getItem("darkMode") === "true";
    console.log("Is dark mode:", isDarkMode);

    // Check if averageOverTimeContainerTarget exists
    console.log("hasFirstContainerTarget:", this.hasFirstContainerTarget);

    // Conditional logic to add/remove dark-mode-border class
    if (this.hasFirstContainerTarget) {
      if (isDarkMode) {
        console.log("Adding dark-mode-border class");
        this.firstContainerTarget.classList.add("background1");
        this.secondContainerTarget.classList.add("background1");
        this.thirdContainerTarget.classList.add("background1");
        this.fourthContainerTarget.classList.add("background1");
        this.leaderboardContainerTarget.classList.add("background1");
        this.leaderNavbarTarget.classList.remove("bg-light");
        this.leaderNavbarTarget.classList.add("background1");
        this.headerTarget.classList.remove("light-mode-text");
        this.headerTarget.classList.add("dark-mode-text");
        this.firstContainerHeaderTarget.classList.add("white-text");
        this.secondContainerHeaderTarget.classList.add("white-text");
        this.recentGamesHeaderTarget.classList.add("white-text");
        this.tableTarget.classList.add("white-text");
        this.leaderboardCardTargets.forEach(card => {
          card.classList.add("white-text", "background2");
        });
        this.navLinkTarget.classList.remove("text-black")
        this.navLinkTarget.classList.add("white-text")
      } else {
        console.log("Removing dark-mode-border class");
        this.firstContainerTarget.classList.remove("background1");
        this.secondContainerTarget.classList.remove("background1");
        this.thirdContainerTarget.classList.remove("background1");
        this.fourthContainerTarget.classList.remove("background1");
        this.leaderboardContainerTarget.classList.remove("background1");
        this.leaderNavbarTarget.classList.add("bg-light");
        this.leaderNavbarTarget.classList.remove("background1");
        this.headerTarget.style.color = "black";
        this.firstContainerHeaderTarget.classList.remove("white-text");
        this.secondContainerHeaderTarget.classList.remove("white-text");
        this.recentGamesHeaderTarget.classList.remove("white-text");
        this.tableTarget.classList.remove("white-text");
        this.leaderboardCardTargets.forEach(card => {
          card.classList.remove("white-text", "background2");
        });
        this.navLinkTarget.classList.add("text-black");
        this.navLinkTarget.classList.remove("white-text");
      }
    }


    if (this.hasCheckboxTarget) {
      console.log("Checkbox checked state:", this.checkboxTarget.checked);
      this.checkboxTarget.checked = isDarkMode;
    }
  }

}
