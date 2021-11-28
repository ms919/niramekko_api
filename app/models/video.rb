class Video < ApplicationRecord
  belongs_to :user
  has_many :laughed_videos, dependent: :destroy

  scope :revenge_playlists, -> (user_id){ joins(:laughed_videos).where(laughed_videos: {user_id: user_id}).group(:id) }
end
