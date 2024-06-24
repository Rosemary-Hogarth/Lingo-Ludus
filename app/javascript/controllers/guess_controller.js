import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guess"
export default class extends Controller {

  static targets = ["input", "difficulty", "category", "definition", "guessContainer"];

  createGame(event) {       // creates all games
    event.preventDefault();

    const difficultyLevel = this.difficultyTarget.value; // sets difficulty from the dropdown input field
    const categoryId = this.categoryTarget.value;        // sets category from the dropdown input field

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
        this.definitionTarget.innerHTML = data.definition;  // extracts the word's definition
        this.element.dataset.gameId = data.game_id;         // extracts the game_id
        this.updateGuessContainer(data.word_array);         // triggers the update of the guess container using selected word_array
      } else if (data.error) {
        alert("Game creation failed: " + data.error);
      } else {
        alert("Game creation failed: Unknown error");
      }
    })
    .catch(error => console.error("Error:", error));
  }

  checkFields(event) {  // triggers the check of input fields when all on the same line are filled
    if (!event) return;

    const attempts = event.target.dataset.attempts; // extracts the attempt value from the data-attempts so attemps variable now hold the identifier of the current line checked
    const rowInputs = this.inputTargets.filter(input => input.dataset.attempts === attempts); // defines an array of input element corresponding to a specific line
                                                                                              // by filtering inputs by inputs by matching data-attempts attribute
    const allFilled = rowInputs.every(input => input.value.trim() !== "");  // checks if all input fields in current line are all filled

    if (allFilled) { // if allfilled is true, calls the check method on all inputs from a specific attempt
        this.check(attempts);
    }
  }

  check(attempts) { // method to check correctness of a letter by using the arrays defines in the guess_word backend method
    const gameId = this.element.dataset.gameId; // retrieves game_id from data-game-id
    console.log(`${gameId}`);

    if (!gameId) {
      console.error("Game ID is not set.");
      return;
    }

    const inputData = {};                                                       // Empty object to store data
    this.inputTargets
        .filter(input => input.dataset.attempts === attempts)                   // filters the inputTarget to get the one belonging to current attempt
        .forEach(input => {                                                     // Iterate through input
            const index = input.dataset.index;
            inputData[`guess_${index}`] = input.value.trim().toLowerCase();     // Retrieve index and value
    });

    console.log("Input data:", inputData); // Log input data to check values

    fetch(`/games/${gameId}/guess_word`, {                                                        // Fetch API request
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content") // Needed for rails to validate the source
      },
      body: JSON.stringify(inputData)
    })
    .then(response => response.json())
    .then(data => {
      console.log(data);                                                                          // debugging
      console.log(`word_array: ${data.word_array}`)                                               // debugging

      this.inputTargets
        .filter(input => input.dataset.attempts === attempts)
        .forEach((input, index) => {
          const guessedLetter = inputData[`guess_${index}`];
          if (data.correct_guesses.includes(index)) {                           // green color for letters included in correct_guesses backend array
            input.style.backgroundColor = "lightgreen";
          } else if (data.wrong_position.includes(index)) {                     // orange color for letters included in wrong_position backend array
            input.style.backgroundColor = "orange";
          } else {
            input.style.backgroundColor = "red";                                // red for all other letters
          }
      });

    })
    .catch(error => console.error("Error:", error));
  }

  addInputListeners() {    // automatically let's you input in the next field
    this.inputTargets.forEach((input, index) => {           // starts a loop that iterates over each element inside inputTargets array
      input.addEventListener("input", (event) => {          // for each element, an event listener is added "input" event happens when the value of input field is changed
        this.checkFields(event);                            // call the checkField method to check if all input fields are filled

        if (input.value.length === input.maxLength) {       // checks if input field is filled comparing its length value to its maxLength attribute (which is 1)
          const nextInput = this.inputTargets[index + 1];   // retrieves the next input field
          if (nextInput) {                                  // if there is a next input available
            nextInput.focus();                              // allows user to type in the next field without clicking on it
          }
        }
      });
    });
  }

  updateGuessContainer(wordArray) {                                       // transition between first static page and game
    this.guessContainerTarget.innerHTML = '';                             // clear the html
    this.guessContainerTarget.classList.remove("guess-container-layout"); // remove layout class
    this.guessContainerTarget.classList.add("guess-container");           // applies new styling class

    let html = '';                                                        // initiate an html variable
    for (let attempts =0; attempts < 3; attempts++) {                     // start a loop that will iterate 3 times
      html += `<div class="guess-field" data-attempts="${attempts}">`     // div containing a line of inputs, has an attempts data index attribute used in other methods
      wordArray.forEach((char, index) => {                                // creates as many input field on a line that there are letter in the word to guess
        html += `
          <div class= "flex-fill">
            <input id="guess_${attempts}_${index}" type="text" size="1" maxlength="1" data-guess-target="input" data-index="${index}" data-attempts="${attempts}" class="form-control guess-input">
          </div>
        `;                // sets the html for each input field, giving them and index in their line and the attempt of their line
      });                 // also sets the maxlength used in addEventListener method and the target "input" used throughout this controller
      html += '</div>';   // closes the div
    }
    this.guessContainerTarget.innerHTML = html; // inserts generated html
    this.addInputListeners();                   // calls the method responsible for automatic typing without clicking on input fields
  }
}
