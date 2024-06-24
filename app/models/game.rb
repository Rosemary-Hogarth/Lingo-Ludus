class Game < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :word, foreign_key: "word_id"

  validates :score, presence: true, numericality: { only_integer: true }
  validates :date, presence: true
  validates :start_time, :end_time, presence: true, on: :update
  validates :difficulty_level, presence: true, inclusion: { in: %w[Beginner Intermediate Advanced] }
  validates :word_id, presence: true


  before_validation :set_default_date, on: :create

  MAX_ATTEMPTS = 3

  def attempts_remaining
    MAX_ATTEMPTS - attempts
  end

  def max_attempts_reached?
    attempts >= MAX_ATTEMPTS
  end

  def select_word(level, category_id)
    words = Word.where(level: level, category_id: category_id)
    words.sample
  end

  def game_duration
    return nil if start_time.nil? || end_time.nil?

    start_time = self.start_time.to_datetime
    end_time = self.end_time.to_datetime

    duration_seconds = (end_time - start_time).to_i
    duration_seconds
  end

  private

  def set_default_date
    self.date ||= Date.today
  end
end
