class Video < ApplicationRecord
  include PLAYLISTS

  belongs_to :user, optional: true
  has_many :laughed_videos, dependent: :destroy
  has_many :hidden_videos, dependent: :destroy
  has_many :latest_top_records, dependent: :nullify

  scope :filter_videos, -> (user_id){ where.not(id: HiddenVideo.select(:video_id).where(user_id: user_id)).where(cannot_play_flg: false) }
  scope :revenge_playlists, -> (user_id){ joins(:laughed_videos).where(laughed_videos: {user_id: user_id}).group(:id) }
  scope :playlist_order, -> { order("RANDOM()").limit(MAX) }
  scope :latest_top_videos, -> { where(id: LaughedVideo.select(:video_id).latest_laughed_videos.score_diff_order) }

  validates :user, presence: true, on: :create
  validates :video_user, presence: true, length: { maximum: 24 }  # TikTok usernameのMax
  validates :data_video_id, presence: true, length: { is: 19 }    # TikTok videoidの長さ
  validates :data_video_id, uniqueness: true
  validates :latest_top_flg, inclusion: {in: [true, false]}
  validates :cannot_play_flg, inclusion: {in: [true, false]}

  def self.can_create_revenge_playlists?(user_id)
    filter_videos(user_id).revenge_playlists(user_id).length >= MIN
  end

  def self.select_videos(mode, user_id)
    case mode
    when GameResult.modes[:normal] then
      filter_videos(user_id).playlist_order
    when GameResult.modes[:dojo] then
      filter_videos(user_id).where(latest_top_flg: true).playlist_order
    when GameResult.modes[:revenge] then
      filter_videos(user_id).revenge_playlists(user_id).playlist_order
    end
  end
end
