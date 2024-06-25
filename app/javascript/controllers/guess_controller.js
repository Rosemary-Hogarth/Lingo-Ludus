import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guess"
export default class extends Controller {

  static targets = ["input", "difficulty", "category", "definition", "guessContainer"];

  createGame(event) {       // creates all games
    event.preventDefault();

    const difficultyLevel = this.difficultyTarget.value; // sets difficulty from the dropdown input field
    const categoryId = this.categoryTarget.value;        // sets category from the dropdown input field

    this.currentLine = 0;     // Track the current line (attempt) of inputs
    this.inputLines = 3;      // Total number of lines (attempts)

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
        this.disableInputsForLine(this.currentLine);        // calls the method that will disable second and third lines
        this.addInputListeners();
      } else if (data.message) {
        alert(data.message);
      } else if (data.error) {
        alert("Game creation failed: " + data.error);
      } else {
        alert("Game creation failed: Unknown error");
      }
    })
    .catch(error => console.error("Error:", error));
  }

  disableInputsForLine(line) { // method for disabling lines preventing the user to input in another line than its current attempt
    this.inputTargets.forEach(input => {              // iterates through the inputTargets array
      const line = parseInt(input.dataset.attempts);  // retrieve the value of data-attempts from current input element
      if (line === this.currentLine) {                // if the line extracted from data-attempts matches the current line
        input.disabled = false;                       // allows inputs
      } else {
        input.disabled = true;                        // if not, disable inputs
      }
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
            <input id="guess_${attempts}_${index}" type="text" size="1" maxlength="1"
                  data-guess-target="input" data-index="${index}" data-attempts="${attempts}"
                  class="form-control guess-input">
          </div>
        `;                // sets the html for each input field, giving them and index in their line and the attempt of their line
      });                 // also sets the maxlength used in addEventListener method and the target "input" used throughout this controller
      html += '</div>';   // closes the div
    }
    this.guessContainerTarget.innerHTML = html; // inserts generated html
    this.addInputListeners();                   // calls the method responsible for automatic typing without clicking on input fields
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

  checkFields(event) {
    if (!event) return;

    const attempts = event.target.dataset.attempts;
    const rowInputs = this.inputTargets.filter(input => parseInt(input.dataset.attempts) === this.currentLine);
    const allFilled = rowInputs.every(input => input.value.trim() !== "");

    if (allFilled) {
      this.check(attempts);
      if (this.currentLine < this.inputLines - 1) {
        this.currentLine++;
        this.disableInputsForLine();
      }
    }
  }

  check(attempts) {
    const gameId = this.element.dataset.gameId;

    if (!gameId) {
      console.error("Game ID is not set.");
      return;
    }

    const inputData = {};
    this.inputTargets
      .filter(input => input.dataset.attempts === attempts)
      .forEach(input => {
        const index = input.dataset.index;
        inputData[`guess_${index}`] = input.value.trim().toLowerCase();
      });

    console.log("Input data:", inputData);

    fetch(`/games/${gameId}/guess_word`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content")
      },
      body: JSON.stringify(inputData)
    })
      .then(response => response.json())
      .then(data => {
        let correctGuessCount = 0;

        this.inputTargets
          .filter(input => input.dataset.attempts === attempts)
          .forEach((input, index) => {
            if (data.correct_guesses.includes(index)) {
              input.style.backgroundColor = "lightgreen";
              correctGuessCount++;
            } else if (data.wrong_position.includes(index)) {
              input.style.backgroundColor = "orange";
            } else {
              input.style.backgroundColor = "red";
            }
          });

        if (correctGuessCount === data.word_array.length) {
          alert("You won!");
          this.inputTargets.forEach(input => {
            input.disabled = true;
          });
          return; // Exit function after alerting "You won!"
        }

        // Check if it's the last line and all lines are filled
        if (this.currentLine === this.inputLines - 1) {
          const allFilled = this.inputTargets.every(input => input.value.trim() !== "");
          if (allFilled) {
            alert("You failed!");
          }
        }
      })
      .catch(error => console.error("Error:", error));
  }
}
