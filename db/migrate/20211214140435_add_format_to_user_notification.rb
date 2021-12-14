class AddFormatToUserNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :user_notifications, :format, :integer, null: false
  end
end
