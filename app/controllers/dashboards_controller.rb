class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user # Retrieves the current logged-in user

    if @user.nil?
      redirect_to root_path, alert: "Please sign in to view your dashboard."
      return
    end

    # Calculates the total score dynamically by summing the score column from games associated with the current user (@user)
    # .sum --> active record method
    @total_score = @user.games.sum(:score)

    # Fetches the 5 most recent games played by the user, ordered by end time
    # .order --> active record method
    @recent_games = @user.games.order(end_time: :desc).limit(5)

    # Maps recent games to include game details (would normally return an array of hashes but openStruct.new keeps dot notation)
    @recent_game_details = @recent_games.map do |game|
      OpenStruct.new(
        game: game,
        # No direct relation between game and word --> need word_id in game table?
        # word: game.word.name,
        # level: game.word.level,
        category: game.category.name,
        time: game.end_time,
        attempts: game.attempts,
        score: game.score
      )
    end

    # Calculates the average score of all game details associated with the user
    # .average --> active record method
    @average_score = @user.games.average(:score).to_f
  end
end
