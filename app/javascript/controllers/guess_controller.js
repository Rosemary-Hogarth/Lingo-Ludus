import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guess"
export default class extends Controller {
  connect() {
    console.log("Hello from our first Stimulus controller");
  }
  static targets = ["input"];

  check(event) {

    event.preventDefault();

    const inputData = {};                                                                          // Empty object to store data
    this.inputTargets.forEach(input => {                                                          // Iterate through input
      const index = input.dataset.index;
      inputData[`guess_${index}`] = input.value.trim().toLowerCase();                              // Retrieve index and value
    });

    fetch(`/games/${this.data.get("gameId")}/guess_word`, {                                       // Fetch API request
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content") // Needed for rails to validate the source
      },
      body: JSON.stringify(inputData)
    })
    .then(response => response.json())
    .then(data => {
      console.log(data);
      console.log(`word_array: ${data.word_array}`)

      this.inputTargets.forEach((input, index) => {
        const guessedLetter = inputData[`guess_${index}`];
        if (data.correct_guesses.includes(index)) {                      // changes color depending on which array the letter index is stored
          input.style.backgroundColor = "lightgreen";
        } else if (data.wrong_position.includes(index)) {
          input.style.backgroundColor = "orange";
        } else {
          input.style.backgroundColor = "red";
        }
      });
    })
    .catch(error => console.error("Error:", error));
  }
}
