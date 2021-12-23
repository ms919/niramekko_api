require 'rails_helper'

describe 'hidden_videos' do
  let(:hidden_video){ create(:hidden_video, user: user) }
  let(:user){ create(:user) }
  let(:res){ JSON.parse(response.body) }
  before do
    login_as(hidden_video.user)
  end

  describe '#index' do
    it 'hidden_videos一覧が取得できること' do
      get '/api/v1/hidden_videos', params: { page: 1 }
      expect(res['videos'].length).to eq(1)
      expect(res['total_pages']).to eq(1)
    end
  end

  describe '#create' do
    it 'hidden_videoがDBに登録されること' do
      valid_params = [{ video_id: create(:video).id }]
      expect { post '/api/v1/hidden_videos', params: { _json: valid_params }, as: :json }.to change(HiddenVideo, :count).by(+1)
      expect(response.status).to eq(201)
    end
  end

  describe '#destroy' do
    it '指定したビデオがhidden_videoから削除されること' do
      expect { delete "/api/v1/hidden_videos/#{hidden_video.id}" }.to change(HiddenVideo, :count).by(-1)
      expect(response.status).to eq(202)
    end
  end
end