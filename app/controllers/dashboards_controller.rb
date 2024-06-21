class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user # Retrieves the current logged-in user
    # Filters games to only include those played within the last month.
    @games = @user.games.where("end_time >= ?", 1.month.ago)

    # Calculates the total score dynamically by summing the score column from games associated with the current user (@user)
    # .sum --> active record method
    @total_score = @user.games.sum(:score)

    # Fetches the 5 most recent games played by the user, ordered by end time
    # .order --> active record method
    @recent_games = @user.games.order(end_time: :desc).limit(5)

    # Calculates the average score of all game details associated with the user
    # .average --> active record method
    @average_score = @user.games.average(:score).to_f

    @average_scores_over_time = {
      "January" => 20,
      "February" => 25,
      "March" => 18,
      "April" => 22,
      "" => 30
    }.to_json

    # if ActiveRecord::Base.connection.adapter_name.downcase.include?("sqlite")
    #   # SQLite workaround: Group by month using Ruby
    #   @average_scores_over_time = @games.group_by { |game| game.end_time.beginning_of_month }
    #                                     .transform_values { |games| games.sum(&:score).to_f / games.length }
    # else
    #   # For PostgreSQL
    #   @average_scores_over_time = @games.group("DATE_TRUNC('month', end_time)")
    #                                     .average(:score)
    # end
  end
end
