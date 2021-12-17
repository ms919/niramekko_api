class ChangeNotNullToUserNotification < ActiveRecord::Migration[6.1]
  def change
    change_column_null :user_notifications, :message, false
  end
end
