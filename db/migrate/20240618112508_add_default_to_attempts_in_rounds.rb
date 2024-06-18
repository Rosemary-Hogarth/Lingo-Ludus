class AddDefaultToAttemptsInRounds < ActiveRecord::Migration[7.1]
  def change
    change_column_default :rounds, :attempts, 0
  end
end
