class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user

    # graph #
    @difficulty_attempts = @user.games.group(:difficulty_level).sum(:attempts)

    @difficulty_attempts = {
      "Beginner" => @difficulty_attempts["Beginner"],
      "Intermediate" => @difficulty_attempts["Intermediate"],
      "Advanced" => @difficulty_attempts["Advanced"]
    }

    puts "@average_scores_over_time: #{@average_scores_over_time}"
    # total score container #

    # Calculates the total score dynamically by summing the score column from games associated with the current user
    @total_score = @user.games.sum(:score)

    # Fetches the 5 most recent games played by the user, ordered by end time
    @recent_games = @user.games.order(start_time: :desc).limit(5)

    # extra info container #
    # fetch all games and find the minimum duration by comparing the game duration of each game. Check that time is not nil
    @best_game = Game.all.reject { |game| game.game_duration.nil? }.min_by(&:game_duration)
    @best_time_game = @best_game if @best_game.present?

    # get total number of games
    @number_of_games = @user.games.count
    # get total attempts
    total_attempts = @user.games.sum(:attempts)

    @average_attempts_per_game = @number_of_games.zero? ? 0 : total_attempts.to_f / @number_of_games

    @average_attempts_per_game = @average_attempts_per_game.round
  end
end

    # start_date = 24.hours.ago.beginning_of_hour
    # end_date = Time.now.end_of_hour
    # puts "Start Date: #{start_date}"
    # puts "End Date: #{end_date}"

    # # Filters games to only include those played within the last week.
    # @games = @user.games.where(start_time: start_date..end_date)
    # puts "Number of games within the last hour: #{@games.count}"

    # # Calculates the average score over the last 24 hours, grouped by hour
    # @average_scores_over_time = @games.group_by_hour(:start_time).average(:score).transform_keys { |key| key.strftime("%H:%M:%S") }.transform_values(&:to_f).to_json

      # Calculates the average score of all game details associated with the user
    # @average_score = @user.games.average(:score).to_f
