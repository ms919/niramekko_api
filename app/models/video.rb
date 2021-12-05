class Video < ApplicationRecord
  belongs_to :user, optional: true
  has_many :laughed_videos, dependent: :destroy
  has_many :hidden_videos, dependent: :destroy

  scope :filter_hidden_videos, -> (user_id){ where.not(id: HiddenVideo.select(:video_id).where(user_id: user_id)) }
  scope :revenge_playlists, -> (user_id){ joins(:laughed_videos).where(laughed_videos: {user_id: user_id}).group(:id) }

  validates :data_video_id, uniqueness: { scope: :user_id }, unless: -> { user_id.blank? }
  validates :user_id, presence: true, on: :create
  validates :video_user, presence: true, length: { maximum: 24 }  # tiktok usernameのMax
  validates :data_video_id, presence: true, length: { is: 19 }    # tiktok videoidの長さ
  validates :latest_top_flg, inclusion: {in: [true, false]}
end
