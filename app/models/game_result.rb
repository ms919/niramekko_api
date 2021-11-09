class GameResult < ApplicationRecord
  enum mode: { normal: 0, dojyo: 1, revenge: 2 }
end
