class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user # Retrieves the current logged-in user
    start_date = 1.month.ago.beginning_of_hour
    end_date = Time.now.end_of_day

    # Filters games to only include those played within the last week.
    @games = @user.games.where(date: start_date..end_date)
    # Debugging: Check if any games are retrieved
    Rails.logger.debug "Games in the last week: #{@games.inspect}"

    # Calculates the average score over the last week, grouped by day
    @average_scores_over_time = @games.group_by_day(:date).average(:score).transform_values(&:to_f).to_json



    # Calculates the total score dynamically by summing the score column from games associated with the current user (@user)
    # .sum --> active record method
    @total_score = @user.games.sum(:score)

    # Fetches the 5 most recent games played by the user, ordered by end time
    # .order --> active record method
    @recent_games = @user.games.order(end_time: :desc).limit(5)

    # Debugging: Check the average scores over time
    Rails.logger.debug "Recent games: #{@recent_games.inspect}"
    # Calculates the average score of all game details associated with the user
    # .average --> active record method
    @average_score = @user.games.average(:score).to_f

  #   @average_scores_over_time = {
  #     "Monday" => 20,
  #     "Tuesday" => 24,
  #     "Wednesday" => 25,
  #     "Thursday" => 29,
  #     "Friday" => 29,
  #     "Saturday" => 29,
  #     "Sunday" => 30
  #   }.to_json
  end
end





    # if ActiveRecord::Base.connection.adapter_name.downcase.include?("sqlite")
    #   # SQLite workaround: Group by month using Ruby
    #   @average_scores_over_time = @games.group_by { |game| game.end_time.beginning_of_month }
    #                                     .transform_values { |games| games.sum(&:score).to_f / games.length }
    # else
    #   # For PostgreSQL
    #   @average_scores_over_time = @games.group("DATE_TRUNC('month', end_time)")
    #                                     .average(:score)
    # end
