class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories_levels_and_languages, only: %i[new game]

  def new
    @game = current_user.games.new
  end

  def game
    @categories_name = Category.pluck(:name)
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = current_user.games.new(game_params)
    @game.start_time = Time.current                 # starts the "timer"
    language_id = params[:game][:language_id] || default_language_id
    puts language_id
    last_words_id = session[:used_word_ids] ||= []  # makes sure last_words_id is an array, empty if session is empty

    if all_words_used?(@game.difficulty_level, @game.category_id, session[:used_word_ids]) # if all words from a category/level combo have been exhausted
      session[:used_word_ids].delete_if do |word_id|                                       # deletes them from the session so they can be displayed again
        Word.find_by(id: word_id, level: @game.difficulty_level, category_id: @game.category_id) # using these conditions
      end
    end

    word_to_guess = @game.select_word(@game.difficulty_level, @game.category_id, language_id, last_words_id) # calls select_word method from the game model
    if word_to_guess.nil?
      render json: { error: 'No words available for the selected difficulty level.' }, status: :unprocessable_entity
    else
      @game.word_id = word_to_guess.id # sets the right word for this game
      if @game.save
        session[:used_word_ids] << word_to_guess.id # stores the word_id of this game for future exclusion
        render json: { word_array: word_to_guess.name.chars, game_id: @game.id, definition: word_to_guess.definition,
                       start_time: @game.start_time.iso8601 }, status: :created # send relevant information to the stimulus controller
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
    all_words_used = all_words_used?(@game.difficulty_level, @game.category_id, session[:used_word_ids])

    word_letter_counts = Hash.new(0)          # initiates a hash that will contain letters as key and amount of each letter as value
    # Iterate through word_array and increment count of each letter for later comparison
    @word_array.each do |letter|
      word_letter_counts[letter.downcase] += 1
    end
    @game.increment!(:attempts)

    # First check for correct guesses

    params.each do |key, value|                         # iterate through user input
      next unless key.start_with?("guess_")             # filter params to only get the guess ones

      index = key.gsub("guess_", "").to_i               # extract the index from the guessed letter
      guessed_letter = value.downcase                   # sanitize data

      guessed_letter = " " if guessed_letter == " "

      if guessed_letter == @word_array[index].downcase  # compare guessed letter with its corresponding counterpart in word_array
        correct_guesses << index                        # push index of correct letters into correct_guess array
        word_letter_counts[guessed_letter] -= 1         # decrement count of correct letter so we know how many left are in word_array
      end
    end

    # Second check for incorrect and misplaced

    params.each do |key, value|
      next unless key.start_with?("guess_")

      index = key.gsub("guess_", "").to_i
      guessed_letter = value.downcase

      guessed_letter = " " if guessed_letter == " "

      next if correct_guesses.include?(index) # Skip next step if the letter is allready correct

      if @word_array.include?(guessed_letter) && word_letter_counts[guessed_letter] > 0 # ensure misplaced letter are only counted if there are still indentical letters to be guessed
        wrong_position << index                         # push to wrong position if there are still occurences of this letter to be found
        word_letter_counts[guessed_letter] -= 1         # updates remaining count of this specific letter
      else
        incorrect_guesses << index
      end
    end

    if correct_guesses.length == @word_array.length # if there are as many correct guesses as letter to find, end the game and calls method to update score
      win_game(@game)
    elsif @game.attempts == 3 && correct_guesses != @word_array.length # if all three attempts are exhausted end game
      @game.update(end_time: Time.current)
    end

    render json: { # build JSON for Stimulus controller
      category: @game.category.name,
      level: @game.difficulty_level,
      correct_guesses:,
      wrong_position:,
      incorrect_guesses:,
      word_array: @word_array,
      attempts: @game.attempts,
      score: @game.score,
      all_words_used:
    }
  end

  private

  def all_words_used?(difficulty_level, category_id, used_word_ids)
    words = Word.where(level: difficulty_level, category_id:) # search for words with the right category/level combo
    words.count == # returns true if the count of word for a specific combo matches the count of same words
      used_word_ids.count do |id|
        words.pluck(:id).include?(id)
      end
  end # (using ids) in the used_words_id meaning all words have allready been pushed into used_words_id

  def win_game(game)
    if game.attempts == 1
      game.update(score: 3) # 3 points if guessed on first try
    elsif game.attempts == 2
      game.update(score: 2) # 2 points if guessed on second try
    elsif game.attempts == 3
      game.update(score: 1) # 1 point if guessed on third try
    end
    game.update(end_time: Time.current) # stores end_time for future score computation
  end

  def game_params
    params.require(:game).permit(:category_id, :difficulty_level, :attempts, :language_id)
  end

  def default_language_id
    # Define how to find the default language_id, e.g., Language.first.id
    Language.first.id
  end

  def set_categories_levels_and_languages
    @categories = Category.all
    @levels = %w[Beginner Intermediate Advanced]
    @languages = Language.all
  end
end
