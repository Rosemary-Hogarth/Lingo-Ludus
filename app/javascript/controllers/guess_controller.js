import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guess"
export default class extends Controller {
  connect() {
    console.log("Hello from our first Stimulus controller");
  }
  static targets = ["input"];

  check(event) {

    console.log("clicked");

    event.preventDefault();
    const formData = {};
    this.inputTargets.forEach(input => {
      const index = input.dataset.index;
      formData[`guess_${index}`] = input.value.trim().toLowerCase();
    });

    fetch(`/games/${this.data.get("gameId")}/guess_word`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content")
      },
      body: JSON.stringify(formData)
    })
      .then(response => response.json())
      .then(data => {
        this.inputTargets.forEach((input, index) => {
          const isCorrect = data.correct_guesses.includes(index);
          input.style.backgroundColor = isCorrect ? "lightgreen" : "lightcoral";
        });
      })
      .catch(error => console.error("Error:", error));
  }
}
