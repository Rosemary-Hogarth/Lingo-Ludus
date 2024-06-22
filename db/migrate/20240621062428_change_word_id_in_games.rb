class ChangeWordIdInGames < ActiveRecord::Migration[7.1]
  def change
    change_column_null :games, :word_id, true
  end
end
