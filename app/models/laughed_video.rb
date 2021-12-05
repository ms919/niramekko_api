class LaughedVideo < ApplicationRecord
  belongs_to :video

  validates :video, presence: true
  validates :score_diff, presence: true, numericality: true
end
