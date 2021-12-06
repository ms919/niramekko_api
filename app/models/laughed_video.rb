class LaughedVideo < ApplicationRecord
  belongs_to :video

  validates :video, presence: true
  validates :score_diff, presence: true, numericality: true

  scope :latest_laughed_videos, -> { select(:video_id).where(created_at: Time.current.yesterday .. Time.current).group(:video_id) }
end
