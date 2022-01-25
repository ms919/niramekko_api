class LaughedVideo < ApplicationRecord
  include PLAYLISTS

  belongs_to :video

  validates :video, presence: true
  validates :score_diff, presence: true, numericality: true

  scope :latest_laughed_videos, -> { where(created_at: Time.current.yesterday .. Time.current).group(:video_id) }
  scope :score_diff_order, -> { order('avg(laughed_videos.score_diff) desc').limit(MAX) }
end
