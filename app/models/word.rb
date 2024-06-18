class Word < ApplicationRecord
  belongs_to :category
  has_many :rounds

  validates :name, presence: true
  validates :level, presence: true
  validates :definition, presence: true
end
