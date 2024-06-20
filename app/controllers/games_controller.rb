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

    word_to_guess = @game.select_word(@game.difficulty_level, @game.category_id)

    if word_to_guess.nil?
      flash[:alert] = 'No words available for the selected difficulty level.'
      redirect_to new_game_path
    else
      @game.word_id = word_to_guess.id

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
    if @word_to_guess.nil?
      flash[:alert] = 'No word selected for this game.'
      redirect_to new_game_path
    end
  end

  # def update_attempts
  #   @game.increment!(:attempts)
  # end

  # def update_score
  #   @game.update(end_time: Time.current, score: calculate_score)
  # end

  def guess_word
    if @game.attempts < 3
      @game.update(attempts: @game.attempts + 1)
      @word_to_guess = @game.word.name

      if @word_to_guess.downcase.strip == params[:guess].downcase.strip
        flash[:notice] = "Correct guess!"
      else
        flash[:alert] = "Incorrect guess. Try again!"
      end
    else
      flash[:alert] = "You have reached the maximum number of attempts."
    end
    redirect_to @game
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
