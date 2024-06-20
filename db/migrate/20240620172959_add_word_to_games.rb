class AddWordToGames < ActiveRecord::Migration[7.1]
  def change
    add_reference :games, :word, null: false, foreign_key: true
  end
end
