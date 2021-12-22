require 'rails_helper'

describe '笑ったビデオ一覧POST処理' do
  let(:video_list){ create_list(:video, 2) }
  let(:res){ JSON.parse(response.body) }

  context '未ログインの場合' do
    it '笑ったビデオ一覧がDBに登録され、戻り値がnilであること' do
      valid_params = [{ video_id: video_list[0].id, score_diff: 10.0 }, { video_id: video_list[1].id, score_diff: 20.0 }]
      expect { post '/api/v1/laughed_videos', params: { _json: valid_params }, as: :json }.to change(LaughedVideo, :count).by(+2)
      expect(res[:revenge_flg]).to eq nil
    end
  end
end
