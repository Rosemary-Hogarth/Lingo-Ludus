import { Controller } from "@hotwired/stimulus";
import ConfettiController from "./confetti_controller";

// Connects to data-controller="guess"
export default class extends Controller {
  static targets = [
    "input",
    "difficulty",
    "language",
    "category",
    "definition",
    "guessContainer",
    "next",
  ];

  connect() {
    this.addedInputListeners = false; // Track if input listeners have been added

    document.addEventListener("keyup", this.enterKeyUp.bind(this));
    console.log("event connected");

    document.addEventListener("keyup", this.enterKeyUp.bind(this));
    console.log("event connected");
  }

  // Method to handle keydown events
  enterKeyUp(event) {
    // Check if the key pressed is Enter (key code 13)
    if (event.keyCode === 13) {
      // Prevent default behavior of the Enter key (form submission)
      event.preventDefault();

      // Trigger click on the "Next" button
      // console.log("keyup")
      this.nextTarget.click();
    }
  }

  createGame(event) {
    // creates all games
    event.preventDefault();

    const difficultyLevel = this.difficultyTarget.value; // sets difficulty from the dropdown input field
    const categoryId = this.categoryTarget.value; // sets category from the dropdown input field
    const languageId = this.languageTarget.value;

    this.currentLine = 0; // Track the current line (attempt) of inputs
    this.inputLines = 3; // Total number of lines (attempts)

    fetch("/games", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify({
        game: {
          difficulty_level: difficultyLevel,
          category_id: categoryId,
          language_id: languageId,
        },
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        // console.log("Response data:", data);
        if (data.word_array) {
          this.definitionTarget.innerHTML = `<p>${data.definition}</p>`; // extracts the word's definition
          this.element.dataset.gameId = data.game_id; // extracts the game_id
          this.updateGuessContainer(data.word_array); // triggers the update of the guess container using selected word_array
          this.disableInputsForLine(this.currentLine); // calls the method that will disable second and third lines
          this.updateButtonToNext();
          this.startTimer(data.start_time); // Call method to insert timer element

          if (!this.addedInputListeners) {
            this.addInputListeners(); // calls method to add event listener on each input field
            this.addedInputListeners = true; // Ensure listeners are added only once
          }

          // Automatically focus the first input field
          const firstInput = this.inputTargets.find(
            (input) => parseInt(input.dataset.attempts) === 0
          );
          if (firstInput) {
            firstInput.focus();
          }
        } else if (data.message) {
          alert(data.message); // just here for now to have feedback displayed on the browser when exhausting all words
        } else if (data.error) {
          alert("Game creation failed: " + data.error);
        } else {
          alert("Game creation failed: Unknown error");
        }
      })
      .catch((error) => console.error("Error:", error));
  }

  // Method to insert timer element dynamically
  startTimer(startTime) {
    // Before creating a new timer, remove the existing timer if it exists
    const existingTimer = document.querySelector("[data-controller='timer']");
    if (existingTimer) {
      existingTimer.remove(); // Remove the existing timer from the DOM
    }

    // Create a new timer element
    const timerElement = document.createElement("div");
    timerElement.setAttribute("data-controller", "timer");
    timerElement.setAttribute("data-timer-start-time", startTime); // Ensure startTime is set correctly
    timerElement.innerHTML = `<div class="timer"><span data-timer-target="time">00:00:00</span></div>`;

    // Insert the timer element into the DOM
    this.element.appendChild(timerElement);
  }

  disableInputsForLine(line) {
    // Method for disabling inputs based on current line and whitespace condition
    this.inputTargets.forEach((input) => {
      const attempts = parseInt(input.dataset.attempts);

      // Check if it's a whitespace character
      if (input.dataset.char === " ") {
        input.disabled = true; // Always disable whitespace inputs
      } else if (attempts === this.currentLine) {
        input.disabled = false; // Enable for current line
      } else {
        input.disabled = true; // Disable for other lines
      }
    });
  }

  updateGuessContainer(wordArray) {
    // Transition between the first static page and the game
    this.guessContainerTarget.innerHTML = ""; // Clear the HTML
    this.guessContainerTarget.classList.remove("guess-container-layout"); // Remove layout class
    this.guessContainerTarget.classList.add("guess-container"); // Apply new styling class

    let html = ""; // Initialize an HTML variable
    for (let attempts = 0; attempts < 3; attempts++) {
      // Start a loop that will iterate 3 times
      html += `<div class="guess-field" data-attempts="${attempts}">`; // Div containing a line of inputs, has an attempts data index attribute used in other methods
      wordArray.forEach((char, index) => {
        // Create as many input fields on a line as there are letters in the word to guess
        html += `
          <div class="flex-fill">
            <input id="guess_${attempts}_${index}" type="text" size="1" maxlength="1"
                  data-guess-target="input" data-dark-mode-target="input" data-index="${index}" data-attempts="${attempts}"
                  data-char="${char}" class="form-control guess-big guess-big-${attempts} border border-dark rounded-2">
          </div>
        `;
      });
      html += "</div>"; // Close the div
    }
    this.guessContainerTarget.innerHTML = html; // Insert generated HTML
    this.addInputListeners(); // Call the method responsible for automatic typing without clicking on input fields
  }

  addInputListeners() {
    this.inputTargets.forEach((input, index) => {
      input.addEventListener("input", (event) => {
        this.checkFields(event);

        if (input.value.length === input.maxLength) {
          let nextInput = null;
          for (let i = index + 1; i < this.inputTargets.length; i++) {
            const next = this.inputTargets[i];
            if (
              parseInt(next.dataset.attempts) === this.currentLine &&
              !next.disabled
            ) {
              nextInput = next;
              break;
            }
          }
          if (nextInput) {
            nextInput.focus();
          }
        }
      });
    });
  }

  checkFields(event) {
    if (!event) return;

    const attempts = event.target.dataset.attempts; // Accessing data-attempts attribute from the target input

    // Filter inputs for the current line and only include enabled inputs
    const rowInputs = this.inputTargets.filter(
      (input) =>
        parseInt(input.dataset.attempts) === this.currentLine && !input.disabled
    );

    // Check if all enabled inputs on the current line are filled
    const allFilled = rowInputs.every((input) => input.value.trim() !== "");

    if (allFilled) {
      this.check(attempts); // Trigger your logic when all inputs are filled
      if (this.currentLine < this.inputLines - 1) {
        // Move to the next line if it's not the last line
        this.currentLine++;
        this.disableInputsForLine(this.currentLine); // Disable inputs for the new current line
      }
    }
  }

  check(attempts) {
    const gameId = this.element.dataset.gameId; // retrieves the game_id from the data-game-id

    // if (!gameId) {
    //   console.error("Game ID is not set."); // debugging
    //   return;
    // }

    const inputData = {}; // empty array where we will store the inputs
    this.inputTargets.forEach((input) => {
      const index = input.dataset.index;
      if (input.dataset.attempts === attempts) {
        if (input.disabled) {
          // Treat disabled inputs as whitespace
          inputData[`guess_${index}`] = " ";
        } else {
          inputData[`guess_${index}`] = input.value.trim().toLowerCase();
        }
      }
    });

    // console.log("Input data:", inputData); // debugging

    fetch(`/games/${gameId}/guess_word`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify(inputData),
    })
      .then((response) => response.json())
      .then((data) => {
        // console.log("Response data:", data); // debugging
        let correctGuessCount = 0; // initialize count of correct guesses to later compare it to the length of the array containing the letters of the word to be guessed

        this.inputTargets
          .filter((input) => input.dataset.attempts === attempts) // filter received data to only get the one with data-attempts index that matches the attempts parameter
          .forEach((input, index) => {
            // for each filtered input
            input.style.opacity = "100%";
            if (data.correct_guesses.includes(index)) {
              input.style.backgroundColor = "#18BBB1"; // green background if correct
              // input.style.opacity = "100%"
              correctGuessCount++; // increment the count of correct guesses
            } else if (data.wrong_position.includes(index)) {
              input.style.backgroundColor = "#F9BF3B"; // orange background if misplaced
              // input.style.opacity = "100%"
            } else {
              input.style.backgroundColor = "#FF6042 "; // red background if incorrect
              // input.style.opacity = "100%"
            }
          });

        if (correctGuessCount === data.word_array.length) {
          // compares count of correct letters with length of array containing letters of the word to be guessed

          this.endGame(
            true,
            data.score,
            data.word_array,
            data.all_words_used,
            data.category,
            data.level
          ); // ends the game
          this.inputTargets.forEach((input) => {
            input.disabled = true; // as game is won, disable all input fields
          });
          return; // exit method so what follows is not run
        }

        if (this.currentLine === this.inputLines - 1) {
          // check if it's the last line and all lines are filled
          const allFilled = this.inputTargets.every(
            (input) => input.value.trim() !== ""
          );
          if (allFilled) {
            this.endGame(
              false,
              data.score,
              data.word_array,
              data.all_words_used,
              data.category,
              data.level
            ); // ends the game
          }
        }
      });
    // .catch((error) => console.error("Error:", error)); // debugging
  }

  updateButtonToNext() {
    // turn "play button into next button"
    this.nextTarget.textContent = "Next";
    this.nextTarget.disabled = true;
    this.nextTarget.classList.add("disabled");
  }

  updateButtonToPlay() {
    this.nextTarget.textContent = "Play";
    this.nextTarget.disabled = false;
    this.nextTarget.classList.remove("disabled");
  }

  endGame(win, score, word_array, all_words_used, category, level) {
    // Provides feedback about winning or failing, giving a score if winning, giving the word if failing
    const word = word_array.join("");
    // const feedback = win
    //   ? `Congratulations! You got ${score} points!`
    //   : `Better luck next time! The answer was "${word}"`;
    // const feedbackContainer = this.feedbackTarget;
    // feedbackContainer.innerHTML = "";

    // const feedbackElement = document.createElement("p");
    // feedbackElement.textContent = feedback;
    // feedbackContainer.appendChild(feedbackElement);

    // Provides feedback if all words from category/level combo are exhausted
    const allWordsUsed = all_words_used;
    if (allWordsUsed) {
      // const allWordsUsedElement = document.createElement("p");
      // allWordsUsedElement.textContent = `You have been through all the words for the "${category}" category at a ${level} level! Try again or choose a different combination`;
      // feedbackContainer.appendChild(allWordsUsedElement);
      this.updateButtonToPlay();

      // Trigger confetti if all words are used
      const confettiController = new ConfettiController();
      confettiController.showConfetti();
    }

    this.nextTarget.classList.remove("disabled");
    this.nextTarget.disabled = false;
  }
}
