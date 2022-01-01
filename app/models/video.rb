class Video < ApplicationRecord
  belongs_to :user, optional: true
  has_many :laughed_videos, dependent: :destroy
  has_many :hidden_videos, dependent: :destroy
  has_many :latest_top_records, dependent: :nullify

  scope :filter_videos, -> (user_id){ where.not(id: HiddenVideo.select(:video_id).where(user_id: user_id)).where(cannot_play_flg: false) }
  scope :revenge_playlists, -> (user_id){ joins(:laughed_videos).where(laughed_videos: {user_id: user_id}).group(:id) }
  scope :playlist_order, -> { order("RANDOM()").limit(5) }
  scope :latest_top_videos, -> { where(id: LaughedVideo.select(:video_id).latest_laughed_videos.score_diff_order) }

  validates :user, presence: true, on: :create
  validates :video_user, presence: true, length: { maximum: 24 }  # tiktok usernameのMax
  validates :data_video_id, presence: true, length: { is: 19 }    # tiktok videoidの長さ
  validates :data_video_id, uniqueness: true
  validates :latest_top_flg, inclusion: {in: [true, false]}
  validates :cannot_play_flg, inclusion: {in: [true, false]}
end
