class ChaneWordLevelToString < ActiveRecord::Migration[7.1]
  def change
    change_column :words, :level, :string
  end
end
