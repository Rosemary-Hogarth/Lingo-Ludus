import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guess"
export default class extends Controller {

  static targets = ["input", "difficulty", "category", "definition", "guessContainer"];

  createGame(event) {
    event.preventDefault();

    const difficultyLevel = this.difficultyTarget.value;
    const categoryId = this.categoryTarget.value;

    fetch("/games", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content")
      },
      body: JSON.stringify({
        game: {
          difficulty_level: difficultyLevel,
          category_id: categoryId
        }
      })
    })
    .then(response => response.json())
    .then(data => {
      console.log("Response data:", data);
      if (data.word_array) {
        this.definitionTarget.innerHTML = data.definition;
        this.element.dataset.gameId = data.game_id;
        this.updateGuessContainer(data.word_array);
      } else if (data.error) {
        alert("Game creation failed: " + data.error);
      } else {
        alert("Game creation failed: Unknown error");
      }
    })
    .catch(error => console.error("Error:", error));
  }

  nextGame(event) {
    event.preventDefault();

    const gameId = this.element.dataset.gameId;

    fetch(`/games/${gameId}/next`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content")
      }
    })
    .then(response => response.json())
    .then(data => {
      console.log("Response data:", data);
      if (data.word_array) {
        this.element.dataset.gameId = data.game_id;
        this.updateGuessContainer(data.word_array);
        this.definitionTarget.innerHTML = data.definition;
      } else if (data.error) {
        alert("Game creation failed: " + data.error);
      } else {
        alert("Game creation failed: Unknown error");
      }
    })
    .catch(error => console.error("Error:", error));
  }

  checkFields(event) {
    if (!event) return;

    const attempts = event.target.dataset.attempts;
    const rowInputs = this.inputTargets.filter(input => input.dataset.attempts === attempts);

    const allFilled = rowInputs.every(input => input.value.trim() !== "");

    if (allFilled) {
        this.check(attempts);
    }
  }

  check(attempts) {
    const gameId = this.element.dataset.gameId;
    console.log(`${gameId}`);

    if (!gameId) {
      console.error("Game ID is not set.");
      return;
    }

    const inputData = {};                                                                          // Empty object to store data
    this.inputTargets
        .filter(input => input.dataset.attempts === attempts)
        .forEach(input => {                                                          // Iterate through input
            const index = input.dataset.index;
            inputData[`guess_${index}`] = input.value.trim().toLowerCase();                              // Retrieve index and value
    });

    console.log("Input data:", inputData); // Log input data to check values

    fetch(`/games/${gameId}/guess_word`, {                                       // Fetch API request
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

      this.inputTargets
        .filter(input => input.dataset.attempts === attempts)
        .forEach((input, index) => {
          const guessedLetter = inputData[`guess_${index}`];
          if (data.correct_guesses.includes(index)) {
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

  addInputListeners() {
    this.inputTargets.forEach(input => {
      input.addEventListener("input", (event) => this.checkFields(event));
    });
  }

  updateGuessContainer(wordArray) {
    this.guessContainerTarget.innerHTML = '';
    this.guessContainerTarget.classList.remove("guess-container-layout");
    this.guessContainerTarget.classList.add("guess-container");

    let html = '';
    for (let attempts =0; attempts < 3; attempts++) {
      html += `<div class="guess-field" data-attempts="${attempts}">`
      wordArray.forEach((char, index) => {
        html += `
          <div class= "flex-fill">
            <input id="guess_${attempts}_${index}" type="text" size="1" data-guess-target="input" data-index="${index}" data-attempts="${attempts}" class="form-control guess-input">
          </div>
        `;
      });
      html += '</div>';
    }
    this.guessContainerTarget.innerHTML = html;
    this.addInputListeners();
  }
}
