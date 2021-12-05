class UserNotification < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :message, length: { maximum:50 }
  validates :read_flg, inclusion: { in: [true, false] }
end
