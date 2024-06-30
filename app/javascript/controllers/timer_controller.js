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
    } else {
      this.stopTimer();
    }
  }

  startTimer() {
    // Attempt to get the start time from the data attribute or use the current time if not provided
    const startTimeStr = this.data.get("startTime");
    this.startTime = startTimeStr ? new Date(startTimeStr) : new Date();
    // Update the time immediately
    this.updateTime();
    // Set an interval to update the time every second
    this.timer = setInterval(() => this.updateTime(), 1000);
    document.getElementById("timerContainer").style.display = ""; // Show timer
  }

  stopTimer() {
    clearInterval(this.timer); // Stops the timer
    document.getElementById("timerContainer").style.display = "none"; // Hide timer
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
