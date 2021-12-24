class LatestTopRecord < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :video, optional: true

  validates :video, presence: true, on: :create
  validates :avg_score, presence: true
end
