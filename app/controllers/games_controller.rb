class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :guess_word]

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
    @word_to_guess = @game.word
    @word_name = @word_to_guess.name
    @word_array = @word_name.chars
    @guessed_letters = flash[:guessed_letters] || @word_array.map { { letter: "", correct: false } }
  end

  # def update_attempts
  #   @game.increment!(:attempts)
  # end

  # def update_score
  #   @game.update(end_time: Time.current, score: calculate_score)
  # end

  def guess_word
    @word_to_guess = @game.word.name
    @word_array = @word_to_guess.chars
    correct_guesses = []
    wrong_position = []

    if @game.attempts < 3
      @game.update(attempts: @game.attempts + 1)

      params.each do |key, value|
        next unless key.start_with?("guess_")
        index = key.gsub("guess_", "").to_i
        guessed_letter = value.downcase.strip

        if guessed_letter == @word_array[index].downcase
          correct_guesses << index
        elsif @word_array.include?(guessed_letter)
          wrong_position << guessed_letter
        end
      end

      render json: { correct_guesses: correct_guesses, wrong_position: wrong_position, word_array: @word_array }
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
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
