require 'rails_helper'

describe 'videos' do
  let(:video){ create(:video, user: user) }
  let(:user){ create(:user) }
  before do
    login_as(video.user)
  end

  describe '#index' do
    let(:res){ JSON.parse(response.body) }
    it 'videos一覧が取得できること' do
      get '/api/v1/videos', params: { page: 1 }
      expect(res['videos'].length).to eq(1)
      expect(res['total_pages']).to eq(1)
    end
  end

  describe '#new' do
    it 'ログインチェックに引っかからないこと' do
      get '/api/v1/videos/new'
      expect(response.status).to eq(204)
    end
  end

  describe '#create' do
    it 'videoがDBに登録されること' do
      valid_params = { video_user: 'test_video_user', data_video_id: format("%019<number>d", number: 999) }
      expect { post '/api/v1/videos', params: valid_params, as: :json }.to change(Video, :count).by(+1)
      expect(response.status).to eq(201)
    end
  end

  describe '#destroy' do
    it '指定したビデオがvideoから削除されること' do
      expect { delete "/api/v1/videos/#{video.id}" }.to change(Video, :count).by(-1)
      expect(response.status).to eq(202)
    end
  end
end