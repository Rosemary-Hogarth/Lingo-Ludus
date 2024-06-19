class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = current_user.games
  end

  def show
    @game = Game.find(params[:id])
    @round = Round.new
  end

  def new
    @game = Game.new
    @categories = Category.all
    @levels = %w[Beginner Intermediate Advanced]
  end

  def create
    @game = current_user.games.new(game_params)
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
  private

  def game_params
    params.require(:game).permit(:category_id, :difficulty_level)
  end

end
