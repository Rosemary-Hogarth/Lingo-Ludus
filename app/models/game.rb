class Game < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :word, class_name: 'Word', foreign_key: 'word_id', optional: true

  validates :score, presence: true, numericality: { only_integer: true }
  validates :date, presence: true
  validates :difficulty_level, presence: true


  before_validation :set_default_date, on: :create

  # create time method start_time - start_time in seconds

  private

  def set_default_date
    self.date ||= Date.today
  end

end
