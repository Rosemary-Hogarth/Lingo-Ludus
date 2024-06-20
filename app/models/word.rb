class Word < ApplicationRecord
  belongs_to :category


  has_many :games, foreign_key: "word_id"


  validates :name, presence: true
  validates :level, presence: true
  validates :definition, presence: true
end
