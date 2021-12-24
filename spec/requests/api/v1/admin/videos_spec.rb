require 'rails_helper'

describe 'admin/videos' do
  before do
    @video = create(:video)
    login_as(create(:user, :admin))
  end

  describe '#index' do
    let(:res){ JSON.parse(response.body) }
    it 'ビデオ一覧が取得できること' do
      get '/api/v1/admin/videos', params: { page: 1 }
      expect(res['videos'].length).to eq(1)
      expect(res['total_pages']).to eq(1)
    end
  end

  describe '#destroy' do
    it 'ビデオを削除できること' do
      expect { delete "/api/v1/admin/videos/#{@video.id}" }.to change(Video, :count).by(-1)
      expect(response.status).to eq(202)
    end
  end
end