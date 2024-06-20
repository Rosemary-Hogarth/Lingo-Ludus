class Game < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :word, class_name: 'Word', foreign_key: 'word_id', optional: true

  validates :score, presence: true, numericality: { only_integer: true }
  validates :date, presence: true
  validates :difficulty_level, presence: true
  validates :start_time, :end_time, presence: true, on: :update
  validates :difficulty_level, presence: true, inclusion: { in: %w[Beginner Intermediate Advanced] }

  before_validation :set_default_date, on: :create

  MAX_ATTEMPTS = 3

  def attempts_remaining
    MAX_ATTEMPTS - attempts
  end

  def max_attempts_reached?
    attempts >= MAX_ATTEMPTS
  end

  private

  def set_default_date
    self.date ||= Date.today
  end
end
