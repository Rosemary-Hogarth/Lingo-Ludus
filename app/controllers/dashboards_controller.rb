class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    calculate_difficulty_attempts
    calculate_total_score
    fetch_recent_games
    fetch_extra_info
    fetch_rankings
  end

  private

  def calculate_difficulty_attempts
    @difficulty_attempts = @user.games.group(:difficulty_level).sum(:attempts)
    @difficulty_attempts = {
      "Beginner" => @difficulty_attempts["Beginner"],
      "Intermediate" => @difficulty_attempts["Intermediate"],
      "Advanced" => @difficulty_attempts["Advanced"]
    }
  end

  def calculate_total_score
    @total_score = @user.games.sum(:score)
  end

  def fetch_recent_games
    @recent_games = @user.games.order(start_time: :desc).limit(5)
  end

  def fetch_extra_info
    @best_game = Game.all.reject { |game| game.game_duration.nil? }.min_by(&:game_duration)
    @best_time_game = @best_game if @best_game.present?

    @number_of_games = @user.games.count
    total_attempts = @user.games.sum(:attempts)
    @average_attempts_per_game = @number_of_games.zero? ? 0 : total_attempts.to_f / @number_of_games
    @average_attempts_per_game = @average_attempts_per_game.round
  end

  def fetch_rankings
    @users = User.left_joins(:games) # includes users with no games
            .select('users.*, COALESCE(SUM(games.score), 0) AS total_score') # coalesce makes score default to 0 if null
            .group('users.id')
            .order('total_score DESC')
  end
end
