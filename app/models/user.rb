class User < ApplicationRecord
  has_many :videos, dependent: :nullify
  has_many :laughed_videos, dependent: :nullify
  has_many :game_results, dependent: :nullify
  has_many :user_notifications, dependent: :destroy
  has_many :hidden_videos, dependent: :destroy
  has_many :latest_top_records, dependent: :destroy

  enum role: { general: 0, admin: 1 }

  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true
  validates :name, length: { maximum: 100 }

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name] ? auth[:info][:name] : auth[:extra][:raw_info][:data][:display_name]
    image_url = auth[:info][:image] ? auth[:info][:image] : auth[:extra][:raw_info][:data][:avatar]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.image_url = image_url
    end
  end
end
