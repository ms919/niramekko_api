require 'rails_helper'
require 'rake_helper'

describe 'process_notifications:organize_user_notifications' do
  subject(:task) { Rake.application['process_notifications:organize_user_notifications'] }

  it '一週間以上前に既読にされたuser_notificationが削除され、新しくuser_notificationが登録されること' do
    create(:user_notification, :read_flg, updated_at: Time.current.ago(7.days))
    create_list(:latest_top_record, 3)
    # 古レコード：-1、新レコード：+3 = +2
    expect { task.invoke }.to change(UserNotification, :count).by(+2)
  end
end