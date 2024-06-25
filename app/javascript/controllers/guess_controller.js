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
        this.addInputListeners();                           // calls method to add event listener on each input field
      } else if (data.message) {
        alert(data.message);        // just here for now to have feedback displayed on the browser when exhausting all words
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

    const attempts = event.target.dataset.attempts; // accessing data attempts attribute from "data-attempts" in the DOM
    const rowInputs = this.inputTargets.filter(input => parseInt(input.dataset.attempts) === this.currentLine); // retrieve all inputs on a specific line defines by its attempts index
    const allFilled = rowInputs.every(input => input.value.trim() !== ""); // checks if all retrieved inputs are filled

    if (allFilled) {
      this.check(attempts);
      if (this.currentLine < this.inputLines - 1) {   // if it is not the last line
        this.currentLine++;                           // increment current line to get to the next one
        this.disableInputsForLine();                  // calls method to only have one line enabled at any time
      }
    }
  }

  check(attempts) {
    const gameId = this.element.dataset.gameId; // retrieves the game_id from the data-game-id

    if (!gameId) {
      console.error("Game ID is not set.");
      return;
    }

    const inputData = {}; // empty array where we will store the inputs
    this.inputTargets
      .filter(input => input.dataset.attempts === attempts)   // filter received data to only get the one with data-attempts index that matches the attempts parameter
      .forEach(input => { // for each filtered input
        const index = input.dataset.index; //retrieve index from data-index
        inputData[`guess_${index}`] = input.value.trim().toLowerCase(); // sanitize data and store as value in inputData with key :"guess_index"
      });

    console.log("Input data:", inputData); // debugging

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
        let correctGuessCount = 0; // initialize count of correct guesses to later compare it to the length of the array containing the letters of the word to be guessed

        this.inputTargets
          .filter(input => input.dataset.attempts === attempts) // filter received data to only get the one with data-attempts index that matches the attempts parameter
          .forEach((input, index) => { // for each filtered input
            if (data.correct_guesses.includes(index)) {
              input.style.backgroundColor = "lightgreen"; // green background if correct
              correctGuessCount++;                        // increment the count of correct guesses
            } else if (data.wrong_position.includes(index)) {
              input.style.backgroundColor = "orange"; // orange background if misplaced
            } else {
              input.style.backgroundColor = "red"; // red background if incorrect
            }
          });

        if (correctGuessCount === data.word_array.length) { // compares count of correct letters with length of array containing letters of the word to be guessed
          alert("You won!"); // browser message
          this.inputTargets.forEach(input => {
            input.disabled = true;              // as game is won, disable all input fields
          });
          return;   // exit method so what follows is not run
        }

        if (this.currentLine === this.inputLines - 1) { // check if it's the last line and all lines are filled
          const allFilled = this.inputTargets.every(input => input.value.trim() !== "");
          if (allFilled) {
            alert("You failed!");   // if this is triggered it means you haven't found the word within 3 attempts
          }
        }
      })
      .catch(error => console.error("Error:", error)); // debugging
  }
}
