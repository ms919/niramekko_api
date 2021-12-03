class User < ApplicationRecord
  has_many :videos, dependent: :nullify
  has_many :laughed_videos, dependent: :destroy
  has_many :game_results, dependent: :destroy
  has_many :user_notifications, dependent: :destroy
  has_many :hidden_videos, dependent: :destroy

  enum role: { general: 0, admin: 1 }

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image_url = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.image_url = image_url
    end
  end
end
