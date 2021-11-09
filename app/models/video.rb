class Video < ApplicationRecord
  has_many :laughed_videos, dependent: :destroy
end
