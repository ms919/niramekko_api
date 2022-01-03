require 'rails_helper'

describe 'playlists' do
  let(:res){ JSON.parse(response.body) }

  describe '#index' do
    context '未ログインの場合' do
      before do
        create(:video)
        create_list(:video, 3, :latest_top)
        create(:video, :cannot_play)
        create(:video, :latest_top, :cannot_play)
      end

      context '通常モードの場合' do
        it '再生可能なものから再生リストが作られること' do
          get '/api/v1/playlists', params: { mode: GameResult.modes[:normal] }
          expect(res.length).to eq(4)
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
        create(:video)
        create(:video, :latest_top, :cannot_play)
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
          Video.find(create(:laughed_video, user_id: user.id).video_id).update(cannot_play_flg: true)
        end
        it 'hidden_video以外でlaughed_videosから再生リストが作られること' do
          get '/api/v1/playlists', params: { mode: GameResult.modes[:revenge] }
          expect(res.length).to eq(3)
          expect(res.find{ |hash| hash['id'] == hidden_video_revenge.video_id}).to eq nil
        end
      end
    end
  end

  describe '#show' do
    let(:cannot_play_id){ video_ids.last }

    context '未ログインの場合' do
      let(:video_ids){ create_list(:video, 5).pluck(:id) }
      context '通常モードの場合' do
        it '再生不可ビデオの再生不可フラグが更新され、再生可能なものから追加取得1件の情報が返されること' do
          new_id = create(:video).id
          get "/api/v1/playlists/#{GameResult.modes[:normal]}", params: { cannot_play_id: cannot_play_id, video_ids: video_ids }
          expect(Video.find(cannot_play_id).cannot_play_flg).to eq(true)
          expect(res[0]['id']).to eq(new_id)
        end
      end
    end

    context 'ログイン中の場合' do
      context '道場モードの場合' do
        let(:hidden_video_latest_top){ create(:hidden_video, user: user, video: create(:video, :latest_top)) }
        let(:video_ids){ create_list(:video, 5, :latest_top).pluck(:id) }
        let(:user){ create(:user) }
        it '再生不可ビデオの再生不可フラグが更新され、再生可能な最新ベストから再生リストが作られること' do
          login_as(hidden_video_latest_top.user)
          get "/api/v1/playlists/#{GameResult.modes[:dojyo]}", params: { cannot_play_id: cannot_play_id, video_ids: video_ids }
          expect(Video.find(cannot_play_id).cannot_play_flg).to eq(true)
          expect(res).to eq([])
        end
      end
    end

    context 'リベンジモードの場合' do
      let(:hidden_video_revenge){ create(:hidden_video, user: user, video: create(:laughed_video, user_id: user.id).video) }
      let(:video_ids){ create_list(:laughed_video, 5, user_id: user.id).pluck(:video_id) }
      let(:user){ create(:user) }
      it '再生不可ビデオの再生不可フラグが更新され、再生可能なlaughed_videosから再生リストが作られること' do
        login_as(hidden_video_revenge.user)
        new_id = create(:laughed_video, user_id: user.id).video_id
        get "/api/v1/playlists/#{GameResult.modes[:revenge]}", params: { cannot_play_id: cannot_play_id, video_ids: video_ids }
        expect(Video.find(cannot_play_id).cannot_play_flg).to eq(true)
        expect(res[0]['id']).to eq(new_id)
      end
    end
  end
end