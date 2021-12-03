class GameResult < ApplicationRecord
  include TITLES

  belongs_to :user, optional: true
  enum mode: { normal: 0, dojyo: 1, revenge: 2 }
  enum title_id: { gold: GOLD, iron: IRON, soil: SOIL, smile: SMILE, laugh: LAUGH}
end
