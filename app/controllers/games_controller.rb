class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show]

  def new
    @game = current_user.games.new
    @categories = Category.all
    @levels = %w[Beginner Intermediate Advanced]
  end

  def create
    @game = current_user.games.new(game_params)
    @game.start_time = Time.current
    if @game.save
      redirect_to @game, notice: 'Game started successfully.'
    else
      @categories = Category.all
      @levels = %w[Beginner Intermediate Advanced]
      flash.now[:alert] = @game.errors.full_messages.to_sentence
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @word = select_word(@game.difficulty_level)
  end

  def update_attempts
    @game.increment!(:attempts)
  end

  def update_score
    @game.update(end_time: Time.current, score: calculate_score)
  end

  private

  def set_game
    @game = current_user.games.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:category_id, :difficulty_level)
  end

  def calculate_score
    elapsed_time = (@game.end_time - @game.start_time).to_i
    base_score = 1000 - (elapsed_time * 10) - (@game.attempts - 1 * 50)
    [base_score, 0].max
  end

  def select_word(level)
    words = @game.category.words.where(level: level)
    words.sample
  end

end
