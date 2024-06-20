class Word < ApplicationRecord
  belongs_to :category
  has_many :games, foreign_key: "word_id"

  validates :name, presence: true
  validates :level, presence: true, inclusion: { in: 1..3, message: "must be between 1 and 3" }
  validates :definition, presence: true
end
