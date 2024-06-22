class AddWordIdToGame < ActiveRecord::Migration[7.1]
  def change
    add_reference :games, :word, foreign_key: true
  end
end
