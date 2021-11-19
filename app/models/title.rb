class Title < ApplicationRecord
  has_many :game_results, dependent: :destroy
end
