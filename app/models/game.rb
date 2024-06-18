class Game < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :rounds

  validates :score, presence: true, numericality: { only_integer: true }
  validates :date, presence: true
  validates :difficulty_level, presence: true
end
