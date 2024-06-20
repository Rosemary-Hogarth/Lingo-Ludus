class AddDefaultValueToAttempts < ActiveRecord::Migration[7.1]
  def change
    change_column :games, :attempts, :integer, default: 0
  end
end
