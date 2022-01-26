class GameResult < ApplicationRecord
  include TITLES

  belongs_to :user, optional: true

  enum mode: { normal: 0, dojo: 1, revenge: 2 }
  enum title: { gold: GOLD, iron: IRON, soil: SOIL, smile: SMILE, laugh: LAUGH}

  validates :mode, presence: true
  validates :title, presence: true
  validates :score, presence: true, numericality: true

  after_initialize do
    set_title(self.score)
  end

  private

  def set_title(score)
    if score >= SCORE_LEVELS[GOLD]
      self.gold!
    elsif score >= SCORE_LEVELS[IRON]
      self.iron!
    elsif score >= SCORE_LEVELS[SOIL]
      self.soil!
    elsif score >= SCORE_LEVELS[SMILE]
      self.smile!
    elsif score < SCORE_LEVELS[SMILE]
      self.laugh!
    end
  end
end
