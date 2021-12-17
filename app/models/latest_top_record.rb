class LatestTopRecord < ApplicationRecord
  belongs_to :user, optional: true

  validates :video, presence: true
  validates :avg_score, presence: true
end
