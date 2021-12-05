class GameResult < ApplicationRecord
  include TITLES

  belongs_to :user, optional: true

  enum mode: { normal: 0, dojyo: 1, revenge: 2 }
  enum title: { gold: GOLD, iron: IRON, soil: SOIL, smile: SMILE, laugh: LAUGH}

  validates :mode, presence: true
  validates :title, presence: true
  validates :score, presence: true, numericality: true
end
