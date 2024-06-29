import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  static targets = ["time"]

  connect() {
    // Get the start time from the data attribute
    this.startTime = new Date(this.data.get("startTime"))
    // Update the time immediately
    this.updateTime()
    // Set an interval to update the time every second
    this.timer = setInterval(() => this.updateTime(), 1000)
  }

  disconnect() {
    // Clear the interval when the controller is disconnected
    clearInterval(this.timer)
  }

  updateTime() {
    // Calculate the elapsed time
    const now = new Date()
    let elapsedTime = Math.floor((now - this.startTime) / 1000)

    const hours = String(Math.floor(elapsedTime / 3600)).padStart(2, '0')
    const minutes = String(Math.floor((elapsedTime % 3600) / 60)).padStart(2, '0')
    const seconds = String(elapsedTime % 60).padStart(2, '0')

    // Update the time target with the formatted time
    this.timeTarget.textContent = `${hours}:${minutes}:${seconds}`
  }
}