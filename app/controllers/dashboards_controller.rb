class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user # Retrieves the current logged-in user

    start_date = 1.week.ago.beginning_of_hour
    end_date = Time.now.end_of_day


    # Filters games to only include those played within the last week.
    @games = @user.games.where(date: start_date..end_date)

    # Calculates the average score over the last week, grouped by day
    @average_scores_over_time = @games.group_by_day(:start_time).average(:score).transform_values(&:to_f).to_json

    # Calculates the total score dynamically by summing the score column from games associated with the current user
    # .sum --> active record method
    @total_score = @user.games.sum(:score)

    # Fetches the 5 most recent games played by the user, ordered by end time
    # .order --> active record method
    @recent_games = @user.games.order(end_time: :desc).limit(5)

    # Calculates the average score of all game details associated with the user
    # .average --> active record method
    @average_score = @user.games.average(:score).to_f

    # get total number of games
    @number_of_games = @user.games.count

    # fetch all games and find the minimum duration by comparing the game duration of each game. Check that time is not nil
    @best_game = Game.all.reject { |game| game.game_duration.nil? }.min_by(&:game_duration)
    @best_time_game = @best_game if @best_game.present?

    # Display as %
    # maximum_score = 100
    # @average_score_percentage = (@user.games.average(:score).to_f / maximum_score) * 100
  end
end
