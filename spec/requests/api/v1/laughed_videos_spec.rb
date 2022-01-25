require 'rails_helper'

describe '#create' do
  let(:video_list){ create_list(:video, MIN) }
  let(:res){ JSON.parse(response.body) }

  context '未ログインの場合' do
    it '笑ったビデオ一覧がDBに登録され、戻り値がnilであること' do
      valid_params = [{ video_id: video_list[0].id, score_diff: 10.0 }, { video_id: video_list[1].id, score_diff: 20.0 }, { video_id: video_list[2].id, score_diff: 30.0 }]
      expect { post '/api/v1/laughed_videos', params: { _json: valid_params }, as: :json }.to change(LaughedVideo, :count).by(MIN)
      expect(res['revenge_flg']).to eq nil
    end
  end

  context 'ログイン中の場合' do
    before do
      login_as(create(:user))
    end
    context 'laughed_videosが2つの場合' do
      it '笑ったビデオ一覧がDBに登録され、戻り値がfalseであること' do
        valid_params = [{ video_id: video_list[0].id, score_diff: 10.0 }, { video_id: video_list[1].id, score_diff: 20.0 }]
        expect { post '/api/v1/laughed_videos', params: { _json: valid_params }, as: :json }.to change(LaughedVideo, :count).by(+2)
        expect(res['revenge_flg']).to eq false
      end
    end
    context 'laughed_videosが3つの場合' do
      it '笑ったビデオ一覧がDBに登録され、戻り値がtrueであること' do
        valid_params = [{ video_id: video_list[0].id, score_diff: 10.0 }, { video_id: video_list[1].id, score_diff: 20.0 }, { video_id: video_list[2].id, score_diff: 30.0 }]
        expect { post '/api/v1/laughed_videos', params: { _json: valid_params }, as: :json }.to change(LaughedVideo, :count).by(MIN)
        expect(res['revenge_flg']).to eq true
      end
    end
  end
end
