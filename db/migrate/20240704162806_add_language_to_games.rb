class AddLanguageToGames < ActiveRecord::Migration[7.1]
  def change
    add_reference :games, :language, null: true, foreign_key: true
  end
end
