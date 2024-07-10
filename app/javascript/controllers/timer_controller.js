import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="timer"
export default class extends Controller {
  static targets = ["time", "btn"];

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
      console.log("checked");
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
    console.log("start timer");
    if (this.timer) {
      clearInterval(this.timer);
    }

    this.startTime = new Date();
    this.elapsedTimeWhenDisabled = null; // Reset frozen time
    this.updateTime();
    this.timer = setInterval(() => this.updateTime(), 1000);

    // const timerContainer = document.getElementById("timerContainer");
    // if (timerContainer) {
    //   timerContainer.style.display = "";
    // }
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

    if (this.btnTarget.disabled) {
      // Update the time target with the formatted time
      let elapsedTime = Math.floor((now - this.startTime) / 1000);
      this.elapsedTimeWhenDisabled = elapsedTime; // Store the elapsed time

      const hours = String(Math.floor(elapsedTime / 3600)).padStart(2, "0");
      const minutes = String(Math.floor((elapsedTime % 3600) / 60)).padStart(2, "0");
      const seconds = String(elapsedTime % 60).padStart(2, "0");

      this.timeTarget.textContent = `${hours}:${minutes}:${seconds} `;
    } else {
      // Display the frozen elapsed time
      if (this.elapsedTimeWhenDisabled !== null) {
        const hours = String(Math.floor(this.elapsedTimeWhenDisabled / 3600)).padStart(2, "0");
        const minutes = String(Math.floor((this.elapsedTimeWhenDisabled % 3600) / 60)).padStart(2, "0");
        const seconds = String(this.elapsedTimeWhenDisabled % 60).padStart(2, "0");

        this.timeTarget.textContent = `${hours}:${minutes}:${seconds}`;
      } else {
        // If the timer hasn't started yet or no elapsed time has been stored
        this.timeTarget.textContent = `00:00:00`;
      }
    }
  }
}
