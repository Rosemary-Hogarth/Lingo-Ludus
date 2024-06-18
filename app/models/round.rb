class Round < ApplicationRecord
  belongs_to :game
  belongs_to :word

  validates :attempts, presence: true, numericality: { only_integer: true }
end
