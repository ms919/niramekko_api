require 'rails_helper'

describe '#index' do
  let(:res){ JSON.parse(response.body) }

  context '未ログインの場合' do
    before do
      create_list(:video, 5)
      create_list(:video, 3, :latest_top)
    end
    context '通常モードの場合' do
      it 'ランダムな5つから再生リストが作られること' do
        get '/api/v1/playlists', params: { mode: GameResult.modes[:normal] }
        expect(res.length).to eq(5)
        expect(res.find{ |hash| hash['latest_top_flg'] == true}).not_to eq nil
        expect(res.find{ |hash| hash['latest_top_flg'] == false}).not_to eq nil
      end
    end
    context '道場モードの場合' do
      it '最新ベストから再生リストが作られること' do
        get '/api/v1/playlists', params: { mode: GameResult.modes[:dojyo] }
        expect(res.length).to eq(3)
        expect(res.find{ |hash| hash['latest_top_flg'] == true}).not_to eq nil
        expect(res.find{ |hash| hash['latest_top_flg'] == false}).to eq nil
      end
    end
  end
end
