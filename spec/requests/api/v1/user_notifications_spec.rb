require 'rails_helper'

describe 'user_notifications' do
  let(:user_notification){ create(:user_notification, user: user) }
  let(:user){ create(:user) }
  let(:res){ JSON.parse(response.body) }
  before do
    login_as(user_notification.user)
  end

  describe '#update' do
    it 'user_notificationを更新できること' do
      patch "/api/v1/user_notifications/#{user_notification.id}"
      expect(res.length).to eq(0)
    end
  end
end