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

  def select_word(level, category_id, last_words_id)
    if last_words_id.blank?
      words = Word.where(level: level, category_id: category_id)
    else
      words = Word.where(level: level, category_id: category_id).where.not(id: last_words_id)
    end
    words.sample
  end

  private

  def set_default_date
    self.date ||= Date.today
  end

  # def select_word(difficulty_level, category_id, last_guessed_word_id = nil)
  #   available_words = Word.where(difficulty_level: difficulty_level, category_id: category_id)
  #   available_words = available_words.where.not(id: last_guessed_word_id) if last_guessed_word_id
  #   available_words.sample
  # end

end
