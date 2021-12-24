require 'rails_helper'

describe 'admin/users' do
  before do
    @user = create(:user)
    login_as(create(:user, :admin))
  end

  describe '#index' do
    let(:res){ JSON.parse(response.body) }
    it 'ユーザー一覧が取得できること' do
      get '/api/v1/admin/users', params: { page: 1 }
      expect(res['users'].length).to eq(2)
      expect(res['total_pages']).to eq(1)
    end
  end

  describe '#destroy' do
    it 'ユーザーを削除できること' do
      expect { delete "/api/v1/admin/users/#{@user.id}" }.to change(User, :count).by(-1)
      expect(response.status).to eq(202)
    end
  end
end