namespace :process_notifications do
  desc 'Organize user_notifications.'
	task organize_user_notifications: :environment do
    # 削除
    UserNotification.destroy_by(updated_at: Time.current.prev_week.all_day, read_flg: true)
    # 登録
    latest_top_records = LatestTopRecord.select(:user_id, :avg_score).where(created_at: Time.current.yesterday .. Time.current)
    if latest_top_records.length > 0
      new_notifications = Bulk::UserNotificationsCollection.new(latest_top_records, UserNotification.formats["latest_top"])
      new_notifications.save
    end
  end
end
