class Video < ApplicationRecord
  belongs_to :user
  has_many :laughed_videos, dependent: :destroy
  has_many :hidden_videos, dependent: :destroy

  scope :filter_hidden_videos, -> (user_id){ where.not(id: HiddenVideo.select(:video_id).where(user_id: user_id)) }
  scope :revenge_playlists, -> (user_id){ joins(:laughed_videos).where(laughed_videos: {user_id: user_id}).group(:id) }
end
