class CreateWords < ActiveRecord::Migration[7.1]
  def change
    create_table :words do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.string :level
      t.text :definition

      t.timestamps
    end
  end
end
