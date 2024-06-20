class DropRound < ActiveRecord::Migration[7.1]
  def change
    drop_table :rounds
  end
end
