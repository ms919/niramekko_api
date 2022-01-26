class GameResult < ApplicationRecord
  include TITLES

  belongs_to :user, optional: true

  enum mode: { normal: 0, dojo: 1, revenge: 2 }
  enum title: { gold: GOLD, iron: IRON, soil: SOIL, smile: SMILE, laugh: LAUGH}

  validates :mode, presence: true
  validates :title, presence: true
  validates :score, presence: true, numericality: true

  after_initialize do
    self.title = calc_title(self.score)
  end

  private

  def calc_title(score)
    if score >= SCORE_LEVELS[GOLD]
      return GOLD
    elsif score >= SCORE_LEVELS[IRON]
      return IRON
    elsif score >= SCORE_LEVELS[SOIL]
      return SOIL
    elsif score >= SCORE_LEVELS[SMILE]
      return SMILE
    elsif score < SCORE_LEVELS[SMILE]
      return LAUGH
    end
  end
end
