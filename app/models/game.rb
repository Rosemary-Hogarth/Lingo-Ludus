class Game < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :word, foreign_key: "word_id"
  belongs_to :language

  validates :score, presence: true, numericality: { only_integer: true }
  validates :date, presence: true
  validates :start_time, :end_time, presence: true, on: :update
  validates :difficulty_level, presence: true, inclusion: { in: %w[Beginner Intermediate Advanced] }
  validates :word_id, presence: true

  before_validation :set_default_date, on: :create

  # MAX_ATTEMPTS = 3

  # def attempts_remaining
  #   MAX_ATTEMPTS - attempts
  # end

  # def max_attempts_reached?
  #   attempts >= MAX_ATTEMPTS
  # end

  def select_word(level, category_id, language_id, last_words_id)
    last_words_id ||= [] # ensure last_words_id is an empty array if nil

    words = Word.where(level:, category_id:, language_id:).where.not(id: last_words_id) # selects words not in last_words_id

    words.sample # returns a single random word
  end

  def game_duration
    return Float::INFINITY if start_time.nil? || end_time.nil?

    (end_time - start_time).to_i
  end

  private

  def set_default_date
    self.date ||= Date.today
  end
end
