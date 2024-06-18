class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :category, null: false, foreign_key: true
      t.string :difficulty_level
      t.references :user, null: false, foreign_key: true
      t.integer :score
      t.datetime :date

      t.timestamps
    end
  end
end
