class Video < ApplicationRecord
  belongs_to :user
  has_many :laughed_videos, dependent: :destroy
end
