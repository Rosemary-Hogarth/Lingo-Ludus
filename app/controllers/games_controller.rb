class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game_and_word, only: [:show, :guess_word]

  def new
    @game = current_user.games.new
    @categories = Category.all
    @levels = %w[Beginner Intermediate Advanced]
  end

  def create
    @game = current_user.games.new(game_params)
    @game.start_time = Time.current

    word_to_guess = @game.select_word(@game.difficulty_level, @game.category_id) # try to find a word with the right parameters

    if word_to_guess.nil?
      flash[:alert] = 'No words available for the selected difficulty level.'
      redirect_to new_game_path
    else
      @game.word_id = word_to_guess.id # associates a word_id to the game

      if @game.save
        redirect_to @game, notice: 'Game started successfully.'
      else
        @categories = Category.all
        @levels = %w[Beginner Intermediate Advanced]
        flash.now[:alert] = @game.errors.full_messages.to_sentence
        render :new, status: :unprocessable_entity
      end
    end
  end

  def show
    @guessed_letters = flash[:guessed_letters] || @word_array.map { { letter: "", correct: false } }
  end

  # def update_attempts
  #   @game.increment!(:attempts)
  # end

  # def update_score
  #   @game.update(end_time: Time.current, score: calculate_score)
  # end

  def guess_word
    correct_guesses = []
    wrong_position = []
    incorrect_guesses = []

    word_letter_counts = Hash.new(0)
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

  def set_game_and_word
    @game = Game.find(params[:id])
    @word_to_guess = @game.word
    @word_name = @word_to_guess.name
    @word_array = @word_name.chars
  end

  def game_params
    params.require(:game).permit(:category_id, :difficulty_level, :attempts)
  end

  def calculate_score
    elapsed_time = (@game.end_time - @game.start_time).to_i
    base_score = 1000 - (elapsed_time * 10) - (@game.attempts - 1 * 50)
    [base_score, 0].max
  end
end
