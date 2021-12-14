class UserNotification < ApplicationRecord
  belongs_to :user

  enum format: { latest_top: 0, video_delete: 1 }

  validates :user, presence: true
  validates :message, length: { maximum:50 }
  validates :read_flg, inclusion: { in: [true, false] }
end
