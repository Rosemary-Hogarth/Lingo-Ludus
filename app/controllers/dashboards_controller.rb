class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user # Retrieves the current logged-in user

    # Calculates the total score dynamically by summing the score column from games associated with the current user (@user)
    # .sum --> active record method
    @total_score = @user.games.sum(:score)

    # Fetches the 5 most recent games played by the user, ordered by end time
    # .order --> active record method
    @recent_games = @user.games.order(end_time: :desc).limit(5)

    # Calculates the average score of all game details associated with the user
    # .average --> active record method
    @average_score = @user.games.average(:score).to_f
  end
end
