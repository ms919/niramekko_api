require 'rails_helper'

describe 'admin/videos' do
  before do
    create(:video)
    @video = create(:video, :cannot_play)
    login_as(create(:user, :admin))
  end

  describe '#index' do
    let(:res){ JSON.parse(response.body) }
    context 'cannot_play_flg == false' do
      it '再生可能なビデオ一覧が取得できること' do
        get '/api/v1/admin/videos', params: { page: 1, cannot_play_flg: false }
        expect(res['videos'].length).to eq(1)
        expect(res['total_pages']).to eq(1)
      end
    end
    context 'cannot_play_flg == true' do
      it '再生不可能なビデオ一覧が取得できること' do
        get '/api/v1/admin/videos', params: { page: 1, cannot_play_flg: true }
        expect(res['videos'].length).to eq(1)
        expect(res['total_pages']).to eq(1)
      end
    end
  end

  describe '#destroy' do
    it 'ビデオを削除できること' do
      expect { delete "/api/v1/admin/videos/#{@video.id}" }.to change(Video, :count).by(-1)
      expect(response.status).to eq(202)
    end
  end
end