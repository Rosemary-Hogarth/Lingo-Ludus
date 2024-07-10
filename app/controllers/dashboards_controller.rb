class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    calculate_difficulty_attempts
    calculate_total_score
    fetch_recent_games
    fetch_extra_info
    fetch_rankings
    fetch_best_times
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
    @last_games = current_user.games.where.not(start_time: nil, end_time: nil).order(start_time: :desc).limit(10)
    valid_games = @last_games.reject { |game| game.game_duration.nil? || game.game_duration == Float::INFINITY }
    @average_time = valid_games.any? ? (valid_games.sum(&:game_duration) / valid_games.count.to_f).round : 'N/A'

    games = current_user.games.where.not(start_time: nil, end_time: nil)
    @number_of_games = games.count
    @average_attempts_per_game = games.any? ? (games.sum(:attempts) / games.count.to_f).round : 0
  end

  def fetch_rankings
    avg_score_per_game =
    @top_score_users = User.left_joins(:games)
                            .select('users.*, COALESCE(SUM(games.score), 0) AS total_score')
                            .group('users.id')
                            .order('total_score DESC, users.id')
                            .limit(10)
  end

  def fetch_best_times
    @best_times = {}
    @average_times = {}
    @top_time_users = User.includes(:games).to_a

    @top_time_users.each do |user|
      recent_games = user.games.where.not(start_time: nil, end_time: nil).order(start_time: :desc).limit(10)
      valid_games = recent_games.reject { |game| game.game_duration.nil? || game.game_duration == Float::INFINITY }
      average_time = valid_games.any? ? (valid_games.sum(&:game_duration) / valid_games.count.to_f).round(1) : 'N/A'

      best_game = user.games.where.not(start_time: nil, end_time: nil).min_by { |game| game.game_duration || Float::INFINITY }
      @best_times[user.id] = best_game.game_duration if best_game.present? && best_game.game_duration.present?
      @average_times[user.id] = average_time
    end

    @top_time_users = @top_time_users.sort_by { |user| @average_times[user.id] == 'N/A' ? Float::INFINITY : @average_times[user.id] }.first(10)
  end
end
