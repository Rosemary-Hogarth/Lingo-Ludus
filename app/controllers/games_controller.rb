class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories_and_levels, only: [:new, :game]


  def new
    @game = current_user.games.new
  end

  def game
    @categories_name = Category.pluck(:name)
  end

  def create
    @game = current_user.games.new(game_params)
    @game.start_time = Time.current         # sets a starting time for scoring
    last_words_id = session[:used_word_ids] # retrieves word_ids store in user session
    word_to_guess = @game.select_word(@game.difficulty_level, @game.category_id, last_words_id) # calls select_word method from game model

    if word_to_guess.nil?   # checks if there is word to guess remaining
      render json: { error: 'No words available for the selected difficulty level.' }, status: :unprocessable_entity
    else
      @game.word_id = word_to_guess.id # sets the word_id attribute of the game to the id of selected word

      if @game.save
        session[:used_word_ids] ||= [] # initializes the array of used word if not allready existing
        session[:used_word_ids] << word_to_guess.id # pushes the id of the word to the array to not be used again
        # next line builds the JSON with all relevant attributes for the stimulus controller to use
        render json: { word_array: word_to_guess.name.chars, game_id: @game.id, definition: word_to_guess.definition }, status: :created
      else
        render json: { error: @game.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    end
  end

  def guess_word
    @game = Game.find(params[:id])
    @word_to_guess = @game.word               # sets word_to_guess retrieving the word_id associated with the current game
    @word_name = @word_to_guess.name.downcase # retrieves the "name" of the word, downcase for sanitizing
    @word_array = @word_name.chars            # creates an array containing the letters of selected word
    correct_guesses = []
    wrong_position = []                       # initiates 3 arrays used to sort letters
    incorrect_guesses = []

    word_letter_counts = Hash.new(0)          # initiates a hash that will contain letters as key and amount of each letter as value
    @word_array.each { |letter| word_letter_counts[letter.downcase] += 1 } # Iterate through word_array and increment count of each letter for later comparison

    if @game.attempts < 3
      @game.update(attempts: @game.attempts + 1)

      # First check for correct guesses

      params.each do |key, value|                         # iterate through user input
        next unless key.start_with?("guess_")             # filter params to only get the guess ones
        index = key.gsub("guess_", "").to_i               # extract the index from the guessed letter
        guessed_letter = value.downcase.strip             # sanitize data

        if guessed_letter == @word_array[index].downcase  # compare guessed letter with its corresponding counterpart in word_array
          correct_guesses << index                        # push index of correct letters into correct_guess array
          word_letter_counts[guessed_letter] -= 1         # decrement count of correct letter so we know how many left are in word_array
        end
      end

      # Second check for incorrect and misplaced

      params.each do |key, value|
        next unless key.start_with?("guess_")
        index = key.gsub("guess_", "").to_i
        guessed_letter = value.downcase.strip

        next if correct_guesses.include?(index)           # Skip next step if the letter is allready correct

        if @word_array.include?(guessed_letter) && word_letter_counts[guessed_letter] > 0 # ensure misplaced letter are only counted if there are still indentical letters to be guessed
          wrong_position << index                         # push to wrong position if there are still occurences of this letter to be found
          word_letter_counts[guessed_letter] -= 1         # updates remaining count of this specific letter
        else
          incorrect_guesses << index
        end
      end

      render json: { correct_guesses: correct_guesses, wrong_position: wrong_position, word_array: @word_array, incorrect_guesses: incorrect_guesses } # build JSON for Stimulus controller
    end
  end

  private

  def game_params
    params.require(:game).permit(:category_id, :difficulty_level, :attempts)
  end

  def set_categories_and_levels
    @categories = Category.all
    @levels = %w[Beginner Intermediate Advanced]
  end
end
