require 'rails_helper'

describe 'playlists' do
  describe '#index' do
    let(:res){ JSON.parse(response.body) }

    context '未ログインの場合' do
      before do
        create_list(:video, 3)
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

    context 'ログイン中の場合' do
      let(:hidden_video){ create(:hidden_video, user: user) }
      let(:hidden_video_latest_top){ create(:hidden_video, user: user, video: create(:video, :latest_top)) }
      let(:hidden_video_revenge){ create(:hidden_video, user: user, video: create(:laughed_video, user_id: user.id).video) }
      let(:user){ create(:user) }
      before do
        create_list(:video, 1)
        create_list(:video, 3, :latest_top)
      end

      context '通常モードの場合' do
        it 'hidden_videoに登録したビデオ以外で再生リストが作られること' do
          login_as(hidden_video.user)
          get '/api/v1/playlists', params: { mode: GameResult.modes[:normal] }
          expect(res.length).to eq(4)
          expect(res.find{ |hash| hash['id'] == hidden_video.video_id}).to eq nil
        end
      end
      context '道場モードの場合' do
        it 'hidden_video以外で最新ベストから再生リストが作られること' do
          login_as(hidden_video_latest_top.user)
          get '/api/v1/playlists', params: { mode: GameResult.modes[:dojyo] }
          expect(res.length).to eq(3)
          expect(res.find{ |hash| hash['latest_top_flg'] == true}).not_to eq nil
          expect(res.find{ |hash| hash['latest_top_flg'] == false}).to eq nil
          expect(res.find{ |hash| hash['id'] == hidden_video_latest_top.video_id}).to eq nil
        end
      end
      context 'リベンジモードの場合' do
        before do
          login_as(hidden_video_revenge.user)
          create_list(:laughed_video, 3, user_id: user.id)
        end
        it 'hidden_video以外でlaughed_videosから再生リストが作られること' do
          get '/api/v1/playlists', params: { mode: GameResult.modes[:revenge] }
          expect(res.length).to eq(3)
          expect(res.find{ |hash| hash['id'] == hidden_video_revenge.video_id}).to eq nil
        end
      end
    end
  end
end