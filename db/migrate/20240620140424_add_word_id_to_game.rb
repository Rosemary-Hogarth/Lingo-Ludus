class AddWordIdToGame < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :word_id, :integer
    add_foreign_key :games, :words, column: :word_id
    add_index :games, :word_id
  end
end
