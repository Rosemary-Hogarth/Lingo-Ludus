class Game < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :rounds

  validates :score, presence: true, numericality: { only_integer: true }
  validates :date, presence: true
  validates :difficulty_level, presence: true

  before_validation :set_default_date, on: :create

  private

  def set_default_date
    self.date ||= Date.today
  end
end
