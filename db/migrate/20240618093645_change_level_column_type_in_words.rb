class ChangeLevelColumnTypeInWords < ActiveRecord::Migration[7.1]
  def change
    remove_column :words, :level
    add_column :words, :level, :integer
  end
end
