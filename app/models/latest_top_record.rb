class LatestTopRecord < ApplicationRecord
  belongs_to :user, optional: true

  validates :avg_score, presence: true
end
