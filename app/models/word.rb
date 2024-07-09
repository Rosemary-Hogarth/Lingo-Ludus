class Word < ApplicationRecord
  belongs_to :category
  belongs_to :language
  has_many :games, foreign_key: "word_id"

  validates :name, presence: true
  validates :level, presence: true,
                    inclusion: { in: %w[Beginner Intermediate Advanced], message: "must be one of Beginner, Intermediate, Advanced" }
  validates :definition, presence: true
end
