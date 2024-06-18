class AddDefaultToScoreInGames < ActiveRecord::Migration[7.1]
  def change
    change_column_default :games, :score, 0
  end
end
