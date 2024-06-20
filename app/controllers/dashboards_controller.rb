class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user # Retrieves the current logged-in user

    # Calculates the total score dynamically by summing the score column from games associated with the current user (@user).
    @total_score = @user.games.sum(:score)

    # Fetches the 5 most recent games played by the user, ordered by end time
    @recent_games = @user.games.order(end_time: :desc).limit(5)

    # retrieves the 5 most recent game details joined with games and ordered by games.end_time descending.
    @recent_game_details = @user.games.joins(:game).order('games.end_time DESC').limit(5)

    # Maps recent games to include game details summing scores, end time, and game ID
    @recent_scores = @recent_games.map do |game|
      {
        game: game, # Reference to the game object
        score: game.games.sum(:score), # Sum of scores from game details associated with the game
        date: game.end_time # End time of the game
      }
    end

    # Calculates the average score of all game details associated with the user
    @average_score = @user.games.average(:score).to_f
  end
end
