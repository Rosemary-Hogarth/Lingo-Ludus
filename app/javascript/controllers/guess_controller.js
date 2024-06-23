import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guess"
export default class extends Controller {

  static targets = ["input", "difficulty", "category", "definition", "guessContainer"];

  addInputListeners() {
    this.inputTargets.forEach(input => {
      input.addEventListener("input", () => this.checkFields(event));
    });
  }

  updateGuessContainer(wordArray) {
    this.guessContainerTarget.innerHTML = '';
    this.guessContainerTarget.classList.remove("guess-container-layout");
    this.guessContainerTarget.classList.add("guess-container");
    let html = '<div class="guess-field">';
    wordArray.forEach((char, index) => {
      html += `
        <div class= "flex-fill">
          <input id="guess_${index}" type="text" size="1" data-guess-target="input" data-index="${index}" class="form-control guess-input">
        </div>
      `;
    });
    html += '</div>';
    this.guessContainerTarget.innerHTML = html;
    this.addInputListeners();
  }

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

  checkFields(event) {
    if (!event) return; // Guard against undefined event
    event.preventDefault();

    const allFilled = Array.from(this.inputTargets).every(input => input.value.trim() !== "");
    if (allFilled) {
      console.log("all filled");
      console.log(`${allFilled}`)
      this.inputTargets.forEach(input => {
        console.log(`Input value for ${input.id}: ${input.value}`);
      });

      this.check(event);
    }
  }

  check(event) {

    event.preventDefault();

    const gameId = this.element.dataset.gameId;
    console.log(`${gameId}`);

    if (!gameId) {
      console.error("Game ID is not set.");
      return;
    }

    const inputData = {};                                                                          // Empty object to store data
    this.inputTargets.forEach(input => {                                                          // Iterate through input
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
