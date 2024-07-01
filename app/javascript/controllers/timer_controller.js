import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="timer"
export default class extends Controller {
  static targets = ["time"];

  connect() {
    this.toggleTimer(); // Call toggleTimer on connect to apply initial state
    // Listen for changes on the checkbox
    document
      .getElementById("enableTimerCheckbox")
      .addEventListener("change", (event) =>
        this.toggleTimer(event.target.checked)
      );
  }

  toggleTimer(isChecked) {
    if (isChecked === undefined) {
      isChecked = document.getElementById("enableTimerCheckbox").checked;
    }

    if (isChecked) {
      this.startTimer();
      this.timeTarget.style.display = ""; // Show the timer
    } else {
      this.stopTimer();
      this.timeTarget.style.display = "none"; // Hide the timer
    }

    // Custom event to signal timer visibility change
    const event = new CustomEvent("timerToggled", {
      detail: { isVisible: isChecked },
    });
    document.dispatchEvent(event);
  }

  startTimer() {
    // Clear any existing timer to avoid duplicates
    if (this.timer) {
      clearInterval(this.timer);
    }

    const startTimeStr = this.data.get("startTime");
    this.startTime = startTimeStr ? new Date(startTimeStr) : new Date();
    this.updateTime();
    this.timer = setInterval(() => this.updateTime(), 1000);

    const timerContainer = document.getElementById("timerContainer");
    if (timerContainer) {
      timerContainer.style.display = "";
    }
  }

  stopTimer() {
    console.log("Stopping timer");
    clearInterval(this.timer);

    const timerContainer = document.getElementById("timerContainer");
    if (timerContainer) {
      timerContainer.style.display = "none";
    }
  }

  disconnect() {
    // Clear the interval when the controller is disconnected
    clearInterval(this.timer);
  }

  updateTime() {
    // Calculate the elapsed time
    const now = new Date();
    let elapsedTime = Math.floor((now - this.startTime) / 1000);

    const hours = String(Math.floor(elapsedTime / 3600)).padStart(2, "0");
    const minutes = String(Math.floor((elapsedTime % 3600) / 60)).padStart(
      2,
      "0"
    );
    const seconds = String(elapsedTime % 60).padStart(2, "0");

    // Update the time target with the formatted time
    this.timeTarget.textContent = `${hours}:${minutes}:${seconds}`;
  }
}
