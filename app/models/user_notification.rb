class UserNotification < ApplicationRecord
  belongs_to :user

  enum format: { latest_top: 0, video_delete: 1 }

  scope :not_read_notifications, -> (user_id){ where(user_id: user_id, read_flg: false).order(:id).select(:id, :message, :format) }

  validates :user, presence: true
  validates :message, length: { maximum:50 }
  validates :read_flg, inclusion: { in: [true, false] }
end
